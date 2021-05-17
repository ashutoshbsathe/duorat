import argparse
import glob
import json


def collect_synthetic_data(tsv_files_folder_path: str, output_data_file):
    output_data = []
    for file_name in glob.iglob(f'{tsv_files_folder_path}/**/*.tsv', recursive=True):
        with open(file_name) as f:
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

                output_data.append(example_dict)

    with open(output_data_file, 'w') as outf:
        json.dump(output_data, outf, indent=4, sort_keys=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--tsv-files-folder-path", required=True)
    parser.add_argument("--output-data-file", required=True)
    args = parser.parse_args()

    collect_synthetic_data(tsv_files_folder_path=args.tsv_files_folder_path,
                           output_data_file=args.output_data_file)
