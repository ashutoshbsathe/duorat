# Latency for Inference
# Cong Duy Vu Hoang, 5-5-2021

import argparse
import json
import os
import time
import re

from duorat.api import DuoratAPI, DuoratOnDatabase
from duorat.preproc.slml import pretty_format_slml
from duorat.utils.evaluation import find_any_config
from duorat.asdl.lang.spider.spider_transition_system import SpiderTransitionSystem


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--logdir", required=True)
    parser.add_argument("--config",
                        help="The configuration file. By default, an arbitrary configuration from the logdir is loaded")
    parser.add_argument("--db-folder-path",
                        help="The folder path to DB folder")
    parser.add_argument("--data-type", type=str, default='Spider', required=False,
                        help="The data type, e.g., Spider, Sparc, CoSQL")
    parser.add_argument("--beam-size", type=int, default=1, required=False,
                        help="The beam size of beam search decoding")
    parser.add_argument(
        "--eval-file", required=True,
        help="The path to the evaluation file in JSON"
    )
    parser.add_argument(
        "--output-eval-file", required=True,
        help="The path to the output evaluation file in JSON"
    )
    parser.add_argument(
        "--do-execute", required=False, type=bool, default=False,
        help="Whether to do execution"
    )
    parser.add_argument(
        "--ignored-patterns", required=False, type=str, default="I have left the chat",
        help="Ignore text patterns in question"
    )
    args = parser.parse_args()

    config_path = find_any_config(args.logdir) if args.config is None else args.config

    total_infer_time = 0
    total_exe_time = 0

    load_time = time.perf_counter()
    duorat_api = DuoratAPI(args.logdir, config_path)
    load_time = time.perf_counter() - load_time

    fout_output_eval_file = open(args.output_eval_file, "w")

    with open(args.eval_file) as f:
        eval_data = json.load(f)
        for data_example in eval_data:
            db_id = 'db_id' if args.data_type == 'Spider' else 'database_id'
            db_path = f"{os.path.join(args.db_folder_path, data_example[db_id])}" + f"/{data_example[db_id]}.sqlite"
            schema_path = f"{os.path.join(args.db_folder_path, data_example[db_id], 'tables.json')}"
            if not os.path.exists(schema_path):
                schema_path = ''

            if os.path.exists(db_path) or os.path.exists(schema_path):
                preproc_time = time.perf_counter()
                duorat_on_db = DuoratOnDatabase(duorat_api,
                                                db_path,
                                                schema_path)
                preproc_time = time.perf_counter() - preproc_time
                total_infer_time += preproc_time

                interactions = []
                if 'interaction' in data_example:
                    for interaction in data_example['interaction']:
                        if args.data_type == 'CoSQL' and re.search(args.ignored_patterns, interaction["utterance"]):
                            continue

                        interactions.append((interaction['utterance'], interaction['query']))
                else:
                    interactions.append((data_example['question'], ''))

                for index, interaction in enumerate(interactions):
                    history = None
                    if index > 0:
                        if duorat_api.config['model']['preproc']['interaction_type'] == 'source':
                            history = [interactions[index - 1][0]]
                        elif duorat_api.config['model']['preproc']['interaction_type'] == 'target':
                            history = [interactions[index - 1][1]]

                    question = interaction[0].replace('*', '')
                    print("-" * 20)
                    print(f"{question}")

                    infer_time = time.perf_counter()
                    results = duorat_on_db.infer_query(question,
                                                       history=history,
                                                       beam_size=args.beam_size)
                    if duorat_api.config['model']['preproc']['interaction_type'] == 'target':
                        interactions[index] = (interaction[0], results["query"])
                    infer_time = time.perf_counter() - infer_time
                    total_infer_time += infer_time

                    print(pretty_format_slml(results['slml_question']))
                    print(f'{results["query"]}  ({results["score"]})')
                    print("-" * 20)

                    decoded = []
                    for beam in results['beams']:
                        asdl_ast = beam.ast
                        if isinstance(duorat_on_db.duorat.preproc.transition_system, SpiderTransitionSystem):
                            tree = duorat_on_db.duorat.preproc.transition_system.ast_to_surface_code(
                                asdl_ast=asdl_ast
                            )
                            inferred_code = duorat_on_db.duorat.preproc.transition_system.spider_grammar.unparse(
                                tree=tree, spider_schema=duorat_on_db.schema
                            )
                            inferred_code_readable = ""
                        else:
                            raise NotImplementedError

                        decoded.append(
                            {
                                # "question": orig_item.question,
                                "model_output": asdl_ast.pretty(),
                                "inferred_code": inferred_code,
                                "inferred_code_readable": inferred_code_readable,
                                "score": beam.score,
                            }
                        )

                    decoded_result = {
                        "index": index,
                        "beams": decoded,
                    }

                    fout_output_eval_file.write(json.dumps(decoded_result) + "\n")
                    fout_output_eval_file.flush()

                    if args.do_execute:
                        try:
                            exe_time = time.perf_counter()
                            results = duorat_on_db.execute(results['query'])
                            exe_time = time.perf_counter() - exe_time
                            total_exe_time += exe_time

                            print(results)
                        except Exception as e:
                            print(str(e))

                # release memory if required
                del duorat_on_db

        num_examples = len(eval_data)
        print(f"Loading time: {load_time} secs")
        print(f"Inferring time: {total_infer_time} secs")
        if total_exe_time > 0:
            print(f"Execution time: {total_exe_time} secs")
        print(f"Total: {load_time + total_infer_time + total_exe_time}")
        print(f"Average: {(load_time + total_infer_time + total_exe_time) / num_examples}")

    fout_output_eval_file.flush()
    fout_output_eval_file.close()
