import json
import os
import argparse

from collections import defaultdict
from typing import List, Dict


def main(spider_path, duorat_path, aug_data="", aug_suffix="") -> None:
    tables_json_path = "tables.json"
    examples_paths = ["train_spider.json", "train_others.json", "dev.json"]
    table_file_name = "tables.json"
    example_file_name = "examples.json"
    if aug_data:
        examples_paths.extend(aug_data.split(','))

        if aug_suffix:
            example_file_name = f"examples_{aug_suffix}.json"

    ### 1. Produce tables.json files
    with open(os.path.join(spider_path, tables_json_path), "r") as read_fp:
        payload: List[dict] = json.load(read_fp)

    grouped_payload: Dict[str, dict] = {}
    for item in payload:
        db_id: str = item['db_id']
        assert db_id not in grouped_payload
        grouped_payload[db_id] = item

    for db_id, item in grouped_payload.items():
        with open(os.path.join(duorat_path, db_id, table_file_name), "wt") as write_fp:
            json.dump([item], write_fp, indent=2)

    ### 2. Produce examples.json files
    grouped_payload: Dict[str, List[dict]] = defaultdict(list)
    for examples_path in examples_paths:
        with open(os.path.join(spider_path, examples_path), "r") as read_fp:
            payload: List[dict] = json.load(read_fp)

        for item in payload:
            db_id: str = item['db_id']
            grouped_payload[db_id].append(item)

    for db_id, payload_group in grouped_payload.items():
        with open(os.path.join(duorat_path, db_id, example_file_name), "wt") as write_fp:
            json.dump(payload_group, write_fp, indent=2)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--spider-path", type=str, default='data/spider')
    parser.add_argument("--duorat-path", type=str, default='data/database')
    parser.add_argument("--aug-data", type=str, default='')
    parser.add_argument("--aug-suffix", type=str, default='')
    args = parser.parse_args()

    main(args.spider_path, args.duorat_path, args.aug_data, args.aug_suffix)
