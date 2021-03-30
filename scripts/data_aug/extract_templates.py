import os
import sys
import json
from typing import Dict

import _jsonnet

from duorat.types import SQLSchema
from duorat.utils import registry
from duorat.preproc.slml import SLMLParser
from duorat.preproc import offline  # *** Compulsory for registering duorat.preproc classes
from duorat.preproc.utils import preprocess_schema_uncached, refine_schema_names
from duorat.datasets.spider import (
    schema_dict_to_spider_schema,
)
from third_party.spider.preprocess.get_tables import dump_db_json_schema
from duorat.types import ColumnMatchTag, TableMatchTag, ValueMatchTag


def postprocess(sql: str) -> str:
    # " AirCon " -> "AirCon"
    sql = sql.replace("\"", " \" ")
    sql = sql.replace("  ", " ")
    # sql = sql.replace("\" ", "\"").replace(" \"", "\"")
    ps = 0
    while True:
        ps = sql.find('"', ps)
        if ps != -1:
            pe = sql.find('"', ps + 1)
            if pe != -1:
                sql = sql.replace(sql[ps + 1: pe],
                                  sql[ps + 1: pe].replace(".", "~").replace("NULL", "!!!!").replace("AS", "!!"))
                ps = pe + 1
            else:
                break
        else:
            break

    # 7 . 5 -> 7.5
    sql = sql.replace(" . ", ".")

    # =" -> = "
    # sql = sql.replace("=\"", "= \"")

    # LIKE" -> LIKE "
    # sql = sql.replace("LIKE\"", "LIKE \"")

    # "OR -> " OR
    # sql = sql.replace("\"OR", "\" OR")

    # "AND -> " AND
    # sql = sql.replace("\"AND", "\" AND")

    return sql


def is_sql_keyword(text: str) -> bool:
    s_text = text
    if s_text[0] == '(':
        s_text = s_text[1:]
    if s_text in SQL_KEYWORDS:
        return True
    return False


def extract_nl_template(tab_mask_dict: Dict[str, str],
                        col_mash_dict: Dict[str, Dict],
                        question: str,
                        db_path: str) -> str:
    sql_schema: SQLSchema = preprocess_schema_uncached(
        schema=schema_dict_to_spider_schema(refine_schema_names(dump_db_json_schema(db_path, ""))),
        db_path=db_path,
        tokenize=duorat_preprocessor._schema_tokenize,
    )
    # print(sql_schema)
    slml_question: str = duorat_preprocessor.schema_linker.question_to_slml(
        question=question, sql_schema=sql_schema,
    )
    print(slml_question)
    parser = SLMLParser(sql_schema=sql_schema, tokenizer=duorat_preprocessor.tokenizer)
    parser.feed(data=slml_question)

    nl_token_list = []
    for question_token in parser.question_tokens:
        print(question_token)
        match_tags = question_token.match_tags
        if len(match_tags) > 0:  # matching happens!
            for match_tag in match_tags:
                if isinstance(match_tag, TableMatchTag):
                    table_name = sql_schema.table_names[int(match_tag.table_id)]
                    if table_name in tab_mask_dict:
                        nl_token_list.append(tab_mask_dict[table_name])
                        break  # hacky to avoid multiple matches
                elif isinstance(match_tag, ColumnMatchTag):
                    table_name = sql_schema.table_names[int(match_tag.table_id)]
                    column_name = sql_schema.column_names[int(match_tag.column_id)]
                    if table_name in col_mash_dict:
                        if column_name in col_mash_dict[table_name]:
                            nl_token_list.append(col_mash_dict[table_name][column_name])
                            break  # hacky to avoid multiple matches
                elif isinstance(match_tag, ValueMatchTag):
                    if nl_token_list[-1] == "@VALUE":
                        nl_token_list.pop()
                    nl_token_list.append("@VALUE")
        else:
            nl_token_list.append(question_token.raw_value)

    return ' '.join(nl_token_list)


sql_kw_file = sys.argv[1]
input_file = sys.argv[2]
logdir = sys.argv[3]
duorat_config_file = sys.argv[4]
output_file = sys.argv[5]

# DuoRAT config
print("Initializing DuoRAT config...")
config = json.loads(_jsonnet.evaluate_file(duorat_config_file))
config['model']['preproc']['save_path'] = os.path.join(logdir, "data")

# DuoRAT preprocessor
print("Initializing DuoRAT preprocessor...")
duorat_preprocessor = registry.construct("preproc",
                                         config["model"]["preproc"],)
duorat_preprocessor.load()

# read SQL keywords
SQL_KEYWORDS = set()
with open(sql_kw_file) as f:
    for line in f:
        line = line.strip()
        for kw_token in line.split():
            SQL_KEYWORDS.add(kw_token)

# read data
with open(input_file) as f:
    data = json.load(f)

unique_template_set = set()
templates_by_hardness = {"easy": set(), "medium": set(), "hard": set(), "extra": set()}
questions_by_hardness = {"easy": set(), "medium": set(), "hard": set(), "extra": set()}
templates_by_examples = {}
for item in data["per_item"]:
    gold_sql = item["gold"]
    predicted_sql = postprocess(item["predicted"])
    predicted_parse_error = bool(item["predicted_parse_error"])
    exact = bool(item["exact"])
    db_path = item["db_path"]
    hardness = item["hardness"]
    question = item["question"]

    def _get_table_mask_sid(mask_dict: Dict[str, str], tab_name: str) -> str:
        if tab_name in mask_dict:
            return mask_dict[tab_name]
        mask_dict[tab_name] = f"@TABLE{len(mask_dict)}"
        return mask_dict[tab_name]

    def _get_column_mask_sid(mask_dict: Dict[str, Dict], tab_name: str, col_name: str) -> str:
        if tab_name in mask_dict:
            if col_name in mask_dict[tab_name]:
                return mask_dict[tab_name][col_name]
            else:
                mask_dict[tab_name][col_name] = f"@COLUMN{len(mask_dict[tab_name])}"
        mask_dict[tab_name] = {}
        mask_dict[tab_name][col_name] = f"@COLUMN0"
        return mask_dict[tab_name][col_name]

    # Extract NL template
    nl_template = extract_nl_template(question=question, db_path=db_path)

    # Extract SQL template
    tab_mask_dict = {}
    col_mask_dict = {}
    if exact and not predicted_parse_error:
        prev_sql_token = ''
        predicted_sql_tokens = predicted_sql.split()
        template_sql_token_list = []
        sql_comp_list = ['<', '<=', '>', '>=', '=', '!=', 'LIKE', 'BETWEEN', 'AND']
        for sql_token in predicted_sql_tokens:
            if '.' in sql_token:
                sp = sql_token.split('.')
                if sp[0] == sp[1]:  # hacky :(
                    sql_token = "table.col"

                dot_pos = sql_token.find('.')
                open_bracket_pos = sql_token.find('(') + 1
                if open_bracket_pos == -1:
                    open_bracket_pos = 0

                table_name = sql_token[open_bracket_pos: dot_pos]
                sql_token = sql_token.replace(table_name,
                                              _get_table_mask_sid(mask_dict=tab_mask_dict,
                                                                  tab_name=table_name))

                dot_pos = sql_token.find('.')
                if open_bracket_pos == 0:
                    if sql_token.find(')') == -1:
                        if sql_token.find(',') == -1:
                            col_name = sql_token[dot_pos + 1:]
                        else:
                            col_name = sql_token[dot_pos + 1: sql_token.find(',')]
                    else:
                        col_name = sql_token[dot_pos + 1: sql_token.find(')')]
                else:
                    col_name = sql_token[dot_pos + 1: sql_token.find(')')]

                sql_token = sql_token.replace(col_name, _get_column_mask_sid(mask_dict=col_mask_dict,
                                                                             tab_name=table_name,
                                                                             col_name=col_name))
            elif prev_sql_token == 'FROM' or prev_sql_token == 'JOIN':
                if sql_token.find(")") == -1:
                    sql_token = _get_table_mask_sid(mask_dict=tab_mask_dict, tab_name=sql_token)
                else:
                    sql_token = f"{_get_table_mask_sid(mask_dict=tab_mask_dict, tab_name=sql_token[:-1])})"
            elif not is_sql_keyword(sql_token) and sql_token not in sql_comp_list:
                value_str = "@VALUE"
                if sql_token[-1] == ')':
                    value_str = "@VALUE)"

                if prev_sql_token in sql_comp_list:
                    sql_token = value_str
                elif prev_sql_token == '@VALUE':
                    template_sql_token_list.pop()
                    sql_token = value_str

            prev_sql_token = sql_token
            template_sql_token_list.append(sql_token)

        template_sql = ' '.join(template_sql_token_list)
        print(predicted_sql)
        print(template_sql)
        print()

        unique_template_set.add(template_sql)
        templates_by_hardness[hardness].add(template_sql)
        questions_by_hardness[hardness].add(question)
        if template_sql not in templates_by_examples:
            templates_by_examples[template_sql] = [question]
        else:
            templates_by_examples[template_sql].append(question)

unique_template_list = list(unique_template_set)
print(f"There are {len(unique_template_list)} SQL templates.")
# print(unique_template_list)

with open(output_file, "w") as fout:
    for template in sorted(unique_template_list, key=len):
        fout.write(f"{template}\n")

for key, val in templates_by_hardness.items():
    with open(f"{output_file}.{key}", "w") as fout:
        fout.write(f"{len(val)}\n")
        for template in sorted(list(val), key=len):
            fout.write(f"{template}\n")

for key, val in questions_by_hardness.items():
    with open(f"{output_file}.questions.{key}", "w") as fout:
        fout.write(f"{len(val)}\n")
        for template in sorted(list(val), key=len):
            fout.write(f"{template}\n")

with open(f"{output_file}.by_examples", "w") as fout:
    for key, examples in sorted(templates_by_examples.items(), key=lambda item: len(item[1]), reverse=True):
        # fout.write("-------------------\n")
        # fout.write(f"Template ({len(examples)} examples): {key}\n")
        # fout.write(f"Examples:\n")
        # for example in examples:
        #     fout.write(f"{example}\n")
        fout.write(f"{key}\t{len(examples)}\t{examples}\n")
