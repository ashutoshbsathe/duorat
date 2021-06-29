import json
import argparse
from typing import List


def split_dev_by_dbs(dev_json_file: str,
                     dev_json_output_file_prefix: str,
                     dbs: List[str]):
    dev_data = json.load(open(dev_json_file))
    examples_by_db = {}
    for entry in dev_data:
        db_id = entry["db_id"]
        if db_id not in examples_by_db:
            examples_by_db[db_id] = [entry]
        else:
            examples_by_db[db_id].append(entry)

    examples_including_dbs = []
    examples_excluding_dbs = []
    for db in dbs:
        if db in examples_by_db:
            examples_including_dbs.extend(examples_by_db[db])

    for db, examples in examples_by_db.items():
        if db not in dbs:
            examples_excluding_dbs.extend(examples)

    with open(f"{dev_json_output_file_prefix}_wo_{'_'.join(dbs)}_gold.sql", "w") as outf_gold:
        for example in examples_excluding_dbs:
            outf_gold.write(f"{example['query']}\t{example['db_id']}\n")
    with open(f"{dev_json_output_file_prefix}_wo_{'_'.join(dbs)}.json", "w") as outf_json:
        json.dump(examples_excluding_dbs, outf_json, indent=4, sort_keys=False)

    with open(f"{dev_json_output_file_prefix}_with_{'_'.join(dbs)}_gold.sql", "w") as outf_gold:
        for example in examples_including_dbs:
            outf_gold.write(f"{example['query']}\t{example['db_id']}\n")
    with open(f"{dev_json_output_file_prefix}_with_{'_'.join(dbs)}.json", "w") as outf_json:
        json.dump(examples_including_dbs, outf_json, indent=4, sort_keys=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--dev-json-file", required=True)
    parser.add_argument("--dev-json-output-file-prefix", required=True)
    parser.add_argument("--dbs",  nargs='+', help='<Required> DBs to leave out', required=True)
    args = parser.parse_args()

    split_dev_by_dbs(dev_json_file=args.dev_json_file,
                     dev_json_output_file_prefix=args.dev_json_output_file_prefix,
                     dbs=args.dbs)
