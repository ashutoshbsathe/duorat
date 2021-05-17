import argparse
import glob
import json
from sklearn import model_selection


def collect_synthetic_data(tsv_files_folder_path: str, output_data_file, samples_by_level: int = 100):
    output_data = []
    for file_name in glob.iglob(f'{tsv_files_folder_path}/**/*.tsv', recursive=True):
        print(f"Processing file path: {file_name}...")
        with open(file_name) as f:
            examples = []
            for line in f:
                line = line.strip()
                _, question, query = line.split('\t')
                db_id = file_name.split('/')[-2]
                example_dict = {
                    'db_id': db_id,
                    'query': query,
                    'question': question,
                    'query_toks': '',
                    'query_toks_no_value': '',
                    'question_toks': '',
                    'sql': ''
                }
                examples.append(example_dict)

            if samples_by_level != -1:
                sampled_examples, _ = model_selection.train_test_split(examples,
                                                                       random_state=42,
                                                                       train_size=samples_by_level)
            else:  # otherwise, get all.
                sampled_examples = examples
            output_data.extend(sampled_examples)

    with open(output_data_file, 'w') as outf:
        json.dump(output_data, outf, indent=4, sort_keys=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--tsv-files-folder-path", required=True)
    parser.add_argument("--output-data-file", required=True)
    parser.add_argument("--samples-by-level", type=int, default=100, required=False)
    args = parser.parse_args()

    collect_synthetic_data(tsv_files_folder_path=args.tsv_files_folder_path,
                           output_data_file=args.output_data_file,
                           samples_by_level=args.samples_by_level)
