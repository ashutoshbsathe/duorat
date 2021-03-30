import os
import json
from typing import Dict, Set
import csv

import argparse

import _jsonnet

from duorat.types import SQLSchema
from duorat.utils import registry
from duorat.preproc.slml import SLMLParser
from duorat.preproc import offline  # *** Compulsory for registering duorat.preproc classes
from duorat.preproc.utils import preprocess_schema_uncached, refine_schema_names
from duorat.datasets.spider import (
    schema_dict_to_spider_schema,
)
from duorat.preproc.abstract_preproc import AbstractPreproc
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


def is_sql_keyword(text: str, sql_keyword_set: Set) -> bool:
    s_text = text
    if s_text[0] == '(':
        s_text = s_text[1:]
    if s_text in sql_keyword_set:
        return True
    return False


def extract_nl_template(duorat_preprocessor: AbstractPreproc,
                        tab_mask_dict: Dict[str, str],
                        col_mash_dict: Dict[str, Dict],
                        question: str,
                        db_path: str) -> str:
    sql_schema: SQLSchema = preprocess_schema_uncached(
        schema=schema_dict_to_spider_schema(refine_schema_names(dump_db_json_schema(db_path, ""))),
        db_path=db_path,
        tokenize=duorat_preprocessor._schema_tokenize,
    )
    print(sql_schema)
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
            best_match = None
            for match_tag in match_tags:
                if isinstance(match_tag, TableMatchTag):
                    table_name = sql_schema.original_table_names[match_tag.table_id]
                    if table_name in tab_mask_dict:
                        best_match = tab_mask_dict[table_name]
                        break  # hacky to avoid multiple matches
                elif isinstance(match_tag, ColumnMatchTag):
                    table_name = sql_schema.original_table_names[match_tag.table_id]
                    column_name = sql_schema.original_column_names[match_tag.column_id]
                    if table_name in col_mash_dict:
                        if column_name in col_mash_dict[table_name]:
                            best_match = f"{tab_mask_dict[table_name]}.{col_mash_dict[table_name][column_name]}"
                            break  # hacky to avoid multiple matches
                elif isinstance(match_tag, ValueMatchTag):
                    if nl_token_list[-1] == "@VALUE":
                        nl_token_list.pop()
                    best_match = "@VALUE"
                    break
            if best_match is None:
                nl_token_list.append(question_token.raw_value)
            else:
                if nl_token_list[-1] == best_match:
                    nl_token_list.pop()
                nl_token_list.append(best_match)
        else:
            nl_token_list.append(question_token.raw_value)

    return duorat_preprocessor.tokenizer.detokenize(xs=nl_token_list)


def extract_nl2sql_templates(sql_kw_file: str,
                             input_file: str,
                             output_file: str,
                             output_in_csv: bool,
                             duorat_preprocessor: AbstractPreproc):
    # read SQL keywords
    sql_keyword_set = set()
    with open(sql_kw_file) as f:
        for line in f:
            line = line.strip()
            for kw_token in line.split():
                sql_keyword_set.add(kw_token)

    # read data
    with open(input_file) as f:
        data = json.load(f)

    unique_template_set = set()
    templates_by_hardness = {"easy": set(), "medium": set(), "hard": set(), "extra": set()}
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
            else:
                mask_dict[tab_name] = {}
                mask_dict[tab_name][col_name] = f"@COLUMN0"
            return mask_dict[tab_name][col_name]

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
                elif not is_sql_keyword(text=sql_token,
                                        sql_keyword_set=sql_keyword_set) and sql_token not in sql_comp_list:
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

            sql_template = ' '.join(template_sql_token_list)
            print(f"Predicted SQL: {predicted_sql}")
            print(f"SQL Template: {sql_template}")

            # Extract NL template
            print(tab_mask_dict)
            print(col_mask_dict)
            nl_template = extract_nl_template(duorat_preprocessor=duorat_preprocessor,
                                              tab_mask_dict=tab_mask_dict,
                                              col_mash_dict=col_mask_dict,
                                              question=question,
                                              db_path=db_path)
            print(f"NL: {question}")
            print(f"NL Template: {nl_template}")

            print("------------------------")

            unique_template_set.add((question, nl_template, gold_sql, sql_template))
            templates_by_hardness[hardness].add((question, nl_template, gold_sql, sql_template))

    unique_template_list = list(unique_template_set)
    print(f"There are {len(unique_template_list)} NL<->SQL templates.")
    # print(unique_template_list)

    if not output_in_csv:
        with open(output_file, "w") as fout:
            for question, nl_template, gold_sql, sql_template in sorted(unique_template_list, key=len):
                fout.write(f"{question}\t{nl_template}\t{gold_sql}\t{sql_template}\n")

        for key, val in templates_by_hardness.items():
            with open(f"{output_file}.{key}", "w") as fout:
                fout.write(f"{len(val)}\n")
                for question, nl_template, gold_sql, sql_template in sorted(list(val), key=len):
                    fout.write(f"{question}\t{nl_template}\t{gold_sql}\t{sql_template}\n")
    else:
        fieldnames = ['question', 'question_template', 'gold_sql', 'sql_template']
        with open(output_file, 'w', newline='') as fcsvfile:
            writer = csv.DictWriter(fcsvfile, fieldnames=fieldnames)

            writer.writeheader()
            for question, nl_template, gold_sql, sql_template in sorted(unique_template_list, key=len):
                writer.writerow({'question': question,
                                 'nl_template': nl_template,
                                 'gold_sql': gold_sql,
                                 'sql_template': sql_template
                                 }
                                )

        for key, val in templates_by_hardness.items():
            with open(f"{output_file}.{key}", "w", newline='') as fcsvfile:
                hardness_writer = csv.DictWriter(fcsvfile, fieldnames=fieldnames)

                hardness_writer.writeheader()
                for question, nl_template, gold_sql, sql_template in sorted(list(val), key=len):
                    hardness_writer.writerow({'question': question,
                                              'nl_template': nl_template,
                                              'gold_sql': gold_sql,
                                              'sql_template': sql_template
                                              }
                                             )


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='NL2SQL Template Extraction')
    parser.add_argument("--sql-keyword-list-file",
                        help="The SQL keyword list file", required=True)
    parser.add_argument("--duorat-config-file",
                        help="The DuoRAT config", required=True)
    parser.add_argument("--duorat-prediction-file",
                        help="The DuoRAT prediction file", required=True)
    parser.add_argument("--logdir",
                        help="The logging dir", required=True)
    parser.add_argument("--template-output-file",
                        help="The NL2SQL template output file", required=True)
    parser.add_argument(
        "--output-in-csv",
        default=False,
        action="store_true",
        help="If True, write outputs in CSV format",
    )
    parser.add_argument(
        "--with-stemming",
        default=False,
        action="store_true",
        help="If True, do stemming with schema linker",
    )
    args, _ = parser.parse_known_args()

    # Initialize
    sql_kw_file = args.sql_keyword_list_file
    input_file = args.duorat_prediction_file
    logdir = args.logdir
    duorat_config_file = args.duorat_config_file
    output_file = args.template_output_file

    # DuoRAT config
    print("Initializing DuoRAT config...")
    config = json.loads(_jsonnet.evaluate_file(duorat_config_file))
    config['model']['preproc']['save_path'] = os.path.join(logdir, "data")
    config['model']['preproc']['schema_linker']['with_stemming'] = args.with_stemming

    # DuoRAT preprocessor
    print("Initializing DuoRAT preprocessor...")
    duorat_preprocessor: AbstractPreproc = registry.construct("preproc", config["model"]["preproc"])
    duorat_preprocessor.load()

    # Extract NL2SQL templates
    extract_nl2sql_templates(sql_kw_file=sql_kw_file,
                             input_file=input_file,
                             output_file=output_file,
                             output_in_csv=args.output_in_csv,
                             duorat_preprocessor=duorat_preprocessor)
