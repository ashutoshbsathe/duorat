# Vu Hoang (vu.hoang@oracle.com)
# Oracle Corp.
# Extract custom NER data


import argparse
import json
import os

from typing import Dict, List, Set

import tqdm

from sklearn import model_selection


def extract_custom_ner_data(input_file: str,
                            output_folder: str,
                            data_type: str):
    data = json.load(open(input_file))
    data_by_db = {}
    for entry in tqdm.tqdm(data):
        db_id = entry["db_id"]
        question = entry['schema_custom_ner']['toked_question']
        tags = entry['schema_custom_ner']['tags']

        if db_id not in data_by_db:
            data_by_db[db_id] = [{'toked_question': question, 'tags': tags}]
        else:
            data_by_db[db_id].append({'toked_question': question, 'tags': tags})

    for db_id, entries in data_by_db.items():
        # split into train/test sections
        n_examples_in_val = int(0.1 * len(entries))
        if n_examples_in_val < 1:
            print(f"WARNING: #examples in test has 1 example only for db '{db_id}'.")
            train_entries, test_entries = model_selection.train_test_split(entries,
                                                                           random_state=42,
                                                                           test_size=2)
        else:
            train_entries, test_entries = model_selection.train_test_split(entries,
                                                                           random_state=42,
                                                                           train_size=0.8)

        # Validate the number of labels in test that must exist in train
        def _get_tag_set(entries: List[str]) -> Dict[str, Set[int]]:
            tsets = {}
            for index, entry in enumerate(entries):
                for tag in entry['tags'].split():
                    if tag in tsets:
                        tsets[tag].add(index)
                    else:
                        tsets[tag] = set([index])
            return tsets
        train_tag_set = set(_get_tag_set(entries=train_entries).keys())
        test_sets = _get_tag_set(entries=test_entries)
        index_mask = set()
        for tag, indices in test_sets.items():
            if tag not in train_tag_set:
                # Here, we accept some entries in test which also appears in train.
                for index in indices:
                    if index not in index_mask:
                        train_entries.append(test_entries[index])
                        index_mask.add(index)

        # train
        fout = open(os.path.join(output_folder, f"{db_id}_db_{data_type}_set_train_split.txt"), "w")
        for entry in train_entries:
            fout.write(f"{entry['toked_question']}\n")
            fout.write(f"{entry['tags']}\n")
        fout.flush()
        fout.close()

        # test
        fout = open(os.path.join(output_folder, f"{db_id}_db_{data_type}_set_test_split.txt"), "w")
        for entry in test_entries:
            fout.write(f"{entry['toked_question']}\n")
            fout.write(f"{entry['tags']}\n")
        fout.flush()
        fout.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Extract/split custom NER data')
    parser.add_argument("--input-file",
                        help="The input file", required=True)
    parser.add_argument("--output-folder",
                        help="The output folder", required=True)
    parser.add_argument("--data-type",
                        help="The data type", required=True)
    args, _ = parser.parse_known_args()

    extract_custom_ner_data(input_file=args.input_file,
                            output_folder=args.output_folder,
                            data_type=args.data_type)
