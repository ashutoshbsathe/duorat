import os
from os import listdir
from os.path import join, exists

import argparse

import pydantic
import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from fastapi import File, Form, UploadFile
import shutil
from datetime import datetime
import sqlite3
from typing import Dict
import json
import re
import copy
from collections import OrderedDict

from moz_sql_parser import parse
from moz_sql_parser import format as format_sql

from nltk.tokenize.treebank import TreebankWordDetokenizer

from duorat.api import DuoratAPI, DuoratOnDatabase
from duorat.utils.evaluation import find_any_config
from scripts.train import Logger


# --------------------------------

def dump_db_json_schema(db_file: str, db_id: str) -> Dict:
    """read table, column info, keys, content and dump all to a JSON file"""

    conn = sqlite3.connect(db_file)
    conn.text_factory = lambda b: b.decode(errors='ignore')
    conn.execute("pragma foreign_keys=ON")
    cursor = conn.execute("SELECT name FROM sqlite_master WHERE type='table';")

    data = {
        "type": "database",
        "name": db_id,
        "objects": [],
        # ----
    }

    for i, item in enumerate(cursor.fetchall()):
        table_name = item[0]
        # print(table_name)

        table_info = {
            "type": "table",
            "name": table_name,
            "columns": [],
            "constraints": [],
            "rows": []
        }

        fks = conn.execute(
            "PRAGMA foreign_key_list('{}') ".format(table_name)
        ).fetchall()
        # print(fks)

        fk_holder = []
        fk_holder.extend([[(table_name, fk[3]), (fk[2], fk[4])] for fk in fks])
        # print(fk_holder)
        fk_entries = []
        for fk in fk_holder:
            fk_entry = {
                "type": "FOREIGN KEY",
                "definition": f"FOREIGN KEY (`{fk[0][1]}`) REFERENCES `{fk[1][0]}`(`{fk[1][1]}`)"
            }
            fk_entries.append(fk_entry)

        pk_holder = []
        cur = conn.execute("PRAGMA table_info('{}') ".format(table_name))
        for j, col in enumerate(cur.fetchall()):
            # print(j)
            # print(col)
            if col[5] != 0:  # primary key
                pk_holder.append(col)

            col_entry = {
                "name": col[1],
                "type": col[2]
            }
            table_info["columns"].append(col_entry)

        pk_str = ','.join([f"\"{pk[1]}\"" for pk in pk_holder])
        pk_entries = {
            "type": "PRIMARY KEY",
            "definition": f"PRIMARY KEY ({pk_str})"  # \"Cinema_ID\",\"Film_ID\"
        }
        if len(pk_entries):
            table_info["constraints"].append(pk_entries)
        if len(fk_entries):
            table_info["constraints"].extend(fk_entries)

        cur = conn.execute("SELECT * FROM '{}'".format(table_name))
        for i, row in enumerate(cur.fetchall()):
            # print(i)
            # print(row)
            table_info["rows"].append(list(row))

        data["objects"].append(table_info)

    # print(data)

    return data


# --------------------------------

app = FastAPI()
origins = [
    "http://localhost",
    "http://localhost:8000",
    "http://localhost:8100",
    "http://localhost:8300",
    "http://100.102.86.190:8100",
    "http://100.102.86.190:8300",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

DB_PATH = "./data/database"
DB_PATH_USER = f"{DB_PATH}/user_db"
duorat_model = None
logger = None
do_sql_post_processing = False
detokenizer = TreebankWordDetokenizer()


class Text2SQLInferenceRequest(pydantic.BaseModel):
    text_question: str
    db_id: str
    db_type: str


class Text2SQLWithFollowUpInferenceRequest(Text2SQLInferenceRequest):
    prev_text_question: str


class Text2SQLInferenceResponse(pydantic.BaseModel):
    sql_query: str
    score: str
    execution_result: str


class Text2SQLQueryDBRequest(pydantic.BaseModel):
    query_type: str
    db_id: str


class Text2SQLQueryDBResponse(pydantic.BaseModel):
    db_id: str
    db_json_content: str


def show_schema(duorat_on_db: DuoratOnDatabase):
    for table in duorat_on_db.schema.tables:
        if logger:
            logger.log(f"Table: {table.name} {table.orig_name}")
        else:
            print("Table", f"{table.name} ({table.orig_name})")
        for column in table.columns:
            if logger:
                logger.log(f"    Column {column.name} {column.orig_name}")
            else:
                print("    Column", f"{column.name} ({column.orig_name})")


NEW_VALID = re.compile(r"^[a-zA-Z_%]\w*$")


def postprocess_sql(sql: str) -> str:
    """
    A heuristics-based SQL post-processing function
    Args:
        sql: a raw input sql
    Returns:
        a post-processed sql
    """

    def _detokenize(txt: str) -> str:
        return detokenizer.detokenize(txt.strip().split(" ")).replace(" .", ".")  # This is a temporary fix.

    def _remove_duplicates(txt: str) -> str:
        return ' '.join(list(OrderedDict.fromkeys(txt.replace('%', '').split(' '))))

    def _put_like_operator(txt: str) -> str:
        return ' '.join([f"%{word}%" for word in txt.split(' ')])

    def _mask_dot(txt: str, rev: bool = False) -> str:
        if rev:
            return txt.replace("[DOT]", ".")
        return txt.replace(".", "[DOT]")

    def _should_quote(identifier):
        """
        Return true if a given identifier should be quoted.

        This is usually true when the identifier:

          - is a reserved word
          - contain spaces
          - does not match the regex `[a-zA-Z_]\\w*`

        """
        return identifier != "*" and (not NEW_VALID.match(identifier))

    def _replace_eq_by_like(eq: Dict):
        eq_clause = eq['eq']
        if isinstance(eq_clause[1], str):
            eq_clause[1] = _put_like_operator(_mask_dot(txt=_detokenize(txt=_remove_duplicates(txt=str(eq_clause[1]))),
                                                        rev=False))
        else:
            return

        tmp_eq_clause = copy.deepcopy(eq_clause)
        eq.pop('eq', None)
        eq['like'] = tmp_eq_clause

        return

    try:
        parsed_sql_dict = parse(sql)
        if 'where' in parsed_sql_dict:
            where_clause = parsed_sql_dict['where']
            if 'and' in where_clause or 'or' in where_clause:
                and_or_clause = where_clause['and' if 'and' in where_clause else 'or']
                for eq in and_or_clause:
                    if 'eq' in eq:
                        _replace_eq_by_like(eq=eq)
            else:
                if 'eq' in where_clause:
                    _replace_eq_by_like(eq=where_clause)

            if 'like' in where_clause:
                like_clause = where_clause['like']
                like_clause[1] = _put_like_operator(txt=_detokenize(txt=_remove_duplicates(txt=like_clause[1])))

        return _mask_dot(txt=format_sql(parsed_sql_dict, should_quote=_should_quote), rev=True)
    except Exception as e:
        if logger:
            logger.log(f"[ERROR] - {str(e)}")
        else:
            print(f"[ERROR] - {str(e)}")
        return sql


def ask_any_question(question: str,
                     duorat_on_db: DuoratOnDatabase) -> Text2SQLInferenceResponse:
    if '@EXECUTE' not in question and '@execute' not in question:
        if ('<tm' in question and '</tm>' in question) \
                or ('<cm' in question and '</cm>' in question) \
                or ('<vm' in question and '</vm>' in question):
            model_results = duorat_on_db.infer_query(question='', slml_question=question)
        else:
            model_results = duorat_on_db.infer_query(question=question, slml_question=None)
        sql = model_results['query']
        score = str(model_results["score"])
    else:  # an implicit db execution query (for debugging only)
        sql = re.compile(re.escape('@execute'), re.IGNORECASE).sub('', question).strip()
        score = "n/a"

    if do_sql_post_processing:
        logger.log(f"SQL: {sql}")
        sql = postprocess_sql(sql=sql)

    if logger:
        logger.log(f"Question: {question}")
        logger.log(f"Final SQL: {sql}")

    try:
        exe_results = duorat_on_db.execute(sql)
        if isinstance(exe_results, list):
            exe_results = [tuple([str(r) if not isinstance(r, str) else r for r in list(res)]) for res in exe_results]
        if logger:
            logger.log(f"Execution results: {exe_results}")
        return Text2SQLInferenceResponse(sql_query=sql,
                                         score=score,
                                         execution_result=f"{exe_results}"
                                         )
    except Exception as e:
        print(str(e))

    if logger:
        logger.log("Execution results: [UNEXECUTABLE]")
    return Text2SQLInferenceResponse(sql_query=sql,
                                     score=score,
                                     execution_result="[UNEXECUTABLE]"
                                     )


def ask_any_question_with_followup(question: str,
                                   prev_question: str,  # currently support one previous question only
                                   duorat_on_db: DuoratOnDatabase) -> Text2SQLInferenceResponse:
    if '@EXECUTE' not in question and '@execute' not in question:
        model_results = duorat_on_db.infer_query(question, history=[prev_question])
        sql = model_results['query']
        score = str(model_results["score"])
    else:  # an implicit db execution query (for debugging only)
        sql = re.compile(re.escape('@execute'), re.IGNORECASE).sub('', question).strip()
        score = "n/a"

    if do_sql_post_processing:
        logger.log(f"SQL: {sql}")
        sql = postprocess_sql(sql=sql)

    if logger:
        logger.log(f"Question: {question}")
        logger.log(f"Final SQL: {sql}")

    try:
        exe_results = duorat_on_db.execute(sql)
        if isinstance(exe_results, list):
            exe_results = [tuple([str(r) if not isinstance(r, str) else r for r in list(res)]) for res in exe_results]
        if logger:
            logger.log(f"Execution results: {exe_results}")
        return Text2SQLInferenceResponse(sql_query=sql,
                                         score=score,
                                         execution_result=f"{exe_results}"
                                         )
    except Exception as e:
        print(str(e))

    if logger:
        logger.log("Execution results: [UNEXECUTABLE]")
    return Text2SQLInferenceResponse(sql_query=sql,
                                     score=score,
                                     execution_result="[UNEXECUTABLE]"
                                     )


@app.post('/text2sql/query_db', response_class=JSONResponse)
async def query_db(request: Text2SQLQueryDBRequest):
    print(f'Attempting for a request: {request.query_type}')

    if request.query_type == '[ALL_DB]':
        db_names = [
            df for df in listdir(path=DB_PATH) \
            if exists(join(DB_PATH, df, df + ".sqlite")) and "user_db" not in df and "_test" not in df
        ]

        return jsonable_encoder(
            Text2SQLQueryDBResponse(db_id='[ALL_DB]', db_json_content=json.dumps(db_names, indent=4)))
    elif request.query_type == '[CUR_DB]':
        db_file = join(DB_PATH, request.db_id, request.db_id + ".sqlite")
        if exists(db_file):
            db_json_content = dump_db_json_schema(db_file=db_file, db_id=request.db_id)
        else:
            db_json_content = {}

        return jsonable_encoder(
            Text2SQLQueryDBResponse(db_id=request.db_id, db_json_content=json.dumps(db_json_content, indent=4)))

    return jsonable_encoder(Text2SQLQueryDBResponse(db_id='', db_json_content=''))


@app.post("/text2sql/query_db_file", response_class=JSONResponse)
async def query_db_file(
        db_file: UploadFile = File(...)
):
    print(f'Attempting for a request with db_file={db_file.filename}')
    curtime = datetime.now().strftime("%d%m%Y%H%M%S")
    new_db_id = f"{db_file.filename.replace('.sqlite', '').replace('.db', '')}_userdb_{curtime}"
    user_db_path = f"{DB_PATH_USER}/{new_db_id}.sqlite"
    with open(user_db_path, "wb") as buffer:
        shutil.copyfileobj(db_file.file, buffer)

    return jsonable_encoder(
        Text2SQLQueryDBResponse(db_id=new_db_id, db_json_content=json.dumps(dump_db_json_schema(db_file=user_db_path,
                                                                                                db_id=new_db_id),
                                                                            indent=4)))


@app.post("/text2sql/infer_file", response_class=JSONResponse)
async def text2sql_infer_file(
        db_file: UploadFile = File(...), text_question: str = Form(...)
):
    print(f'Attempting for a request with text="{text_question}" and db_file={db_file.filename}')
    curtime = datetime.now().strftime("%d%m%Y%H%M%S")
    db_path = f"{DB_PATH_USER}/{db_file.filename.replace('.sqlite', '').replace('.db', '')}_{curtime}.sqlite"
    with open(db_path, "wb") as buffer:
        shutil.copyfileobj(db_file.file, buffer)

    if logger:
        logger.log(f'DB path: {db_path}')

    duorat_on_db = DuoratOnDatabase(duorat=duorat_model,
                                    db_path=db_path,
                                    schema_path='')

    show_schema(duorat_on_db=duorat_on_db)
    results = ask_any_question(question=text_question, duorat_on_db=duorat_on_db)
    if not logger:
        print(results)

    return jsonable_encoder(results)


@app.post('/text2sql/infer', response_class=JSONResponse)
async def text2sql_infer(request: Text2SQLInferenceRequest):
    print(f'Attempting for a request: {request}')

    if request.db_type == 'u_db':
        db_path = f"{DB_PATH_USER}/{request.db_id}.sqlite"
        schema_path = ''
    elif request.db_type == 'c_db':
        db_path = f"{DB_PATH}/{request.db_id}/{request.db_id}.sqlite"
        schema_path = f"{DB_PATH}/{request.db_id}/tables.json"
        if not os.path.exists(schema_path):
            schema_path = ""

    if logger:
        logger.log(f'DB path: {db_path}')
        logger.log(f'Schema path: {schema_path}')

    duorat_on_db = DuoratOnDatabase(duorat=duorat_model,
                                    db_path=db_path,
                                    schema_path=schema_path)

    show_schema(duorat_on_db=duorat_on_db)
    results = ask_any_question(question=request.text_question, duorat_on_db=duorat_on_db)
    if not logger:
        print(results)

    return jsonable_encoder(results)


@app.post('/text2sql/infer_followup', response_class=JSONResponse)
async def text2sql_infer_followup(request: Text2SQLWithFollowUpInferenceRequest):
    print(f'Attempting for a request with a follow-up: {request}')

    if request.db_type == 'u_db':
        db_path = f"{DB_PATH_USER}/{request.db_id}.sqlite"
        schema_path = ''
    elif request.db_type == 'c_db':
        db_path = f"{DB_PATH}/{request.db_id}/{request.db_id}.sqlite"
        schema_path = f"{DB_PATH}/{request.db_id}/tables.json"
        if not os.path.exists(schema_path):
            schema_path = ""

    if logger:
        logger.log(f'DB path: {db_path}')
        logger.log(f'Schema path: {schema_path}')

    duorat_on_db = DuoratOnDatabase(duorat=duorat_model,
                                    db_path=db_path,
                                    schema_path=schema_path)

    show_schema(duorat_on_db=duorat_on_db)
    results = ask_any_question_with_followup(question=request.text_question,
                                             prev_question=request.prev_text_question,
                                             duorat_on_db=duorat_on_db)
    if not logger:
        print(results)

    return jsonable_encoder(results)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='DuoRAT Text2SQL Inference Server Version 2.0')
    parser.add_argument("--logdir", required=True)
    parser.add_argument("--server-port", required=False, type=int, default=8000)
    parser.add_argument("--config",
                        help="The configuration file. By default, an arbitrary configuration from the logdir is loaded")
    parser.add_argument("--db-path",
                        help="The database path. By default, ./data/database", default=DB_PATH)
    parser.add_argument(
        "--do-sql-post-processing",
        default=False,
        action="store_true",
        help="If True, do fuzzy string matching mechanism as a post-processing step for generated SQL.",
    )
    parser.add_argument(
        "--do-logging",
        default=False,
        action="store_true",
        help="If True, do logging; otherwise just print",
    )
    parser.add_argument(
        "--log-append",
        default=False,
        action="store_true",
        help="If True, append the content to the log file else re-open a new one.",
    )
    parser.add_argument("--log-file-name",
                        help="The logging file path. By default, ", default='serve.log')

    args, _ = parser.parse_known_args()

    DB_PATH = args.db_path
    DB_PATH_USER = f"{DB_PATH}/user_db"
    try:
        os.makedirs(DB_PATH_USER, exist_ok=True)
    except OSError as error:
        print(error)

    # Initialize the logger
    if args.do_logging:
        log_file = os.path.join(args.logdir, args.log_file_name)
        if not args.log_append:
            with open(log_file, "w") as f:
                f.close()
        logger = Logger(log_path=log_file, reopen_to_flush=False)
        logger.log("Logging to {}".format(log_file))

    if args.do_sql_post_processing:
        do_sql_post_processing = True

    # Initialize the model
    print('Initializing Text2SQL Inference Service...')
    duorat_model = DuoratAPI(args.logdir, find_any_config(args.logdir) if args.config is None else args.config)

    # Start serving service
    uvicorn.run(app, host="0.0.0.0", port=args.server_port)
