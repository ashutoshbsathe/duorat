# Vu Hoang (vu.hoang@oracle.com)
# Oracle Corp.

import argparse
import json
import os

import _jsonnet
import tqdm

from duorat.preproc import offline  # *** Compulsory for registering duorat.preproc classes
from duorat.datasets.spider import (
    schema_dict_to_spider_schema,
)
from duorat.preproc.abstract_preproc import AbstractPreproc
from duorat.preproc.utils import preprocess_schema_uncached, refine_schema_names
from duorat.types import SQLSchema
from duorat.utils import registry
from third_party.spider.preprocess.get_tables import dump_db_json_schema


def get_slml_outputs(duorat_preprocessor: AbstractPreproc,
                     input_file: str,
                     output_file: str,
                     db_folder_path: str):
    # read data
    with open(input_file) as f:
        data = json.load(f)

    for ind, item in enumerate(tqdm.tqdm(data)):
        db_id = item["db_id"]
        db_path = os.path.join(db_folder_path, db_id, f"{db_id}.sqlite")
        question = item["question"]

        sql_schema: SQLSchema = preprocess_schema_uncached(
            schema=schema_dict_to_spider_schema(refine_schema_names(dump_db_json_schema(db_path, ""))),
            db_path=db_path,
            tokenize=duorat_preprocessor._schema_tokenize,
        )
        slml_question: str = duorat_preprocessor.schema_linker.question_to_slml(
            question=question, sql_schema=sql_schema,
        )
        item['slml_question'] = slml_question

    # write output data
    json.dump(data, open(output_file, "w"), indent=4, sort_keys=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Get SLML outputs for a given input file')
    parser.add_argument("--duorat-config-file",
                        help="The DuoRAT config", required=True)
    parser.add_argument("--input-file",
                        help="The input file", required=True)
    parser.add_argument("--output-file",
                        help="The output file", required=True)
    parser.add_argument("--db-folder-path",
                        help="The folder path to DB folder", default='./data/database')
    parser.add_argument(
        "--with-stemming",
        default=False,
        action="store_true",
        help="If True, do stemming with schema linker",
    )
    args, _ = parser.parse_known_args()

    # Initialize
    duorat_config_file = args.duorat_config_file

    # DuoRAT config
    print("Initializing DuoRAT config...")
    config = json.loads(_jsonnet.evaluate_file(duorat_config_file))
    config['model']['preproc']['schema_linker']['with_stemming'] = args.with_stemming

    # DuoRAT preprocessor
    print("Initializing DuoRAT preprocessor...")
    duorat_preprocessor: AbstractPreproc = registry.construct("preproc", config["model"]["preproc"])

    # Extract NL2SQL templates
    print(f"Processing input file from {args.input_file}...")
    get_slml_outputs(duorat_preprocessor=duorat_preprocessor,
                     input_file=args.input_file,
                     output_file=args.output_file,
                     db_path=args.db_folder_path)
