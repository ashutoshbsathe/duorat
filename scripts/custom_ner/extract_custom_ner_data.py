# Vu Hoang (vu.hoang@oracle.com)
# Oracle Corp.
# Extract custom NER data


import argparse
import json
import os

import _jsonnet
import tqdm


def extract_custom_ner_data(input_file: str,
                            output_folder: str):
    data = json.load(open(input_file))
    data_by_db = {}
    for entry in tqdm.tqdm(data):
        db_id = entry["db_id"]
        question = entry['schema_custom_ner']['toked_question']
        tags = entry['schema_custom_ner']['tags']

        if db_id not in data_by_db:
            data_by_db[db_id] = [{'question': question, 'tags': tags}]
        else:
            data_by_db[db_id].append({'question': question, 'tags': tags})

    # split into train/test sections
    # TODO

    for db_id, entries in data_by_db.items():
        fout = open(os.path.join(output_folder, f"{db_id}.txt"), "w")
        for entry in entries:
            fout.write(f"{entry['question']}\n")
            fout.write(f"{entry['tags']}\n")
        fout.flush()
        fout.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Extract custom NER data')
    parser.add_argument("--input-file",
                        help="The input file", required=True)
    parser.add_argument("--output-folder",
                        help="The output folder", required=True)
    args, _ = parser.parse_known_args()

    extract_custom_ner_data(input_file=args.input_file, output_folder=args.output_folder)
