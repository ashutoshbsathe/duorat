import argparse

import pydantic
import uvicorn
from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from fastapi import File, Form, UploadFile
import shutil
from datetime import datetime

from duorat.api import DuoratAPI, DuoratOnDatabase
from duorat.utils.evaluation import find_any_config

app = FastAPI()
DB_PATH = "./data/database"
DB_PATH_USER = f"{DB_PATH}/user_db"
duorat_model = None


class Text2SQLInferenceRequest(pydantic.BaseModel):
    text_question: str
    db_id: str


class Text2SQLInferenceResponse(pydantic.BaseModel):
    sql_query: str
    score: str
    execution_result: str


def show_schema(duorat_on_db: DuoratOnDatabase):
    for table in duorat_on_db.schema.tables:
        print("Table", f"{table.name} ({table.orig_name})")
        for column in table.columns:
            print("    Column", f"{column.name} ({column.orig_name})")


def ask_any_question(question: str,
                     duorat_on_db: DuoratOnDatabase) -> Text2SQLInferenceResponse:
    model_results = duorat_on_db.infer_query(question)

    try:
        exe_results = duorat_on_db.execute(model_results['query'])
        return Text2SQLInferenceResponse(sql_query=model_results["query"],
                                         score=model_results["score"],
                                         execution_result=f"{exe_results}"
                                         )
    except Exception as e:
        print(str(e))

    return Text2SQLInferenceResponse(sql_query=model_results["query"],
                                     score=model_results["score"],
                                     execution_result="[UNEXECUTABLE]"
                                     )


@app.post("/text2sql/infer_new")
async def text2sql_infer_new(
    db_file: UploadFile = File(...), text_question: str = Form(...)
):
    print(f'Attempting for a request with text="{text_question}" and db_file={db_file.filename}')
    curtime = datetime.now().strftime("%d%m%Y%H%M%S")
    db_path = f"{DB_PATH_USER}/{db_file.filename.replace('.sqlite', '')}_{curtime}.sqlite"
    with open(db_path, "wb") as buffer:
        shutil.copyfileobj(db_file.file, buffer)

    duorat_on_db = DuoratOnDatabase(duorat=duorat_model,
                                    db_path=db_path,
                                    schema_path='')

    show_schema(duorat_on_db=duorat_on_db)
    results = ask_any_question(question=text_question, duorat_on_db=duorat_on_db)
    print(results)

    return jsonable_encoder(results)


@app.post('/text2sql/infer', response_class=JSONResponse)
async def text2sql_infer(request: Text2SQLInferenceRequest):
    print(f'Attempting for a request: {request}')

    db_path = f"{DB_PATH}/{request.db_id}/{request.db_id}.sqlite"
    schema_path = f"{DB_PATH}/{request.db_id}/tables.json"

    duorat_on_db = DuoratOnDatabase(duorat=duorat_model,
                                    db_path=db_path,
                                    schema_path=schema_path)

    show_schema(duorat_on_db=duorat_on_db)
    results = ask_any_question(question=request.text_question, duorat_on_db=duorat_on_db)
    print(results)

    return jsonable_encoder(results)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='DuoRAT Text2SQL Inference Server')
    parser.add_argument("--logdir", required=True)
    parser.add_argument("--config",
                        help="The configuration file. By default, an arbitrary configuration from the logdir is loaded")
    parser.add_argument("--db_path",
                        help="The database path. By default, ./data/database", default=DB_PATH)

    args, _ = parser.parse_known_args()

    DB_PATH = args.db_path
    DB_PATH_USER = f"{DB_PATH}/user_db"
    try:
        import os
        os.mkdir(DB_PATH_USER)
    except OSError as error:
        print(error)

    print('Initializing Text2SQL Inference Service...')
    duorat_model = DuoratAPI(args.logdir, find_any_config(args.logdir) if args.config is None else args.config)

    uvicorn.run(app, host="0.0.0.0", port=8000)
