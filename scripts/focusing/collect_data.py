import json
from typing import List
import tqdm
import os
import csv


def collect_spider_wikisql(json_data_files: List[str],
                           json_schema_file: str,
                           output_file: str,
                           data_type: str = 'spider',
                           use_col_type: bool = False) -> None:
    # load data
    spider_data = []
    for data_file in json_data_files:
        with open(data_file) as f:
           data = json.load(f)
           assert isinstance(data, list)
           spider_data.extend(data)

    # load schema
    schema_data = {}
    with open(json_schema_file) as f:
        data = json.load(f)
        for entry in tqdm.tqdm(data):
            schema_data[entry['db_id']] = []

            # column type and names
            if use_col_type:
                for col_type, col_name in zip(entry['column_types'][1:], entry['column_names'][1:]):
                    schema_data[entry['db_id']].append(f"{str(col_type)} {str(col_name[1])}")
            else:
                for col_name in entry['column_names'][1:]:
                    schema_data[entry['db_id']].append(f"{str(col_name[1])}")

            if data_type == 'spider':
                # table names
                schema_data[entry['db_id']].extend([table_name for table_name in entry['table_names']])

    output_data = []
    for example in tqdm.tqdm(spider_data):
        question = example['question'].strip()
        db_id = example['db_id']
        db_schema = schema_data[db_id]

        concat_output = [question]
        for db_info in db_schema:
            concat_output.append('</s>')
            concat_output.append(db_info)

        output_data.append(' '.join(concat_output))

    with open(output_file, 'w') as outf:
        for entry in output_data:
            outf.write(f"{entry}\n")

    return


def collect_wikitablequestions(dataset_path: str, tsv_data_file_name: str, output_file: str) -> None:
    output_data = []
    with open(os.path.join(dataset_path, tsv_data_file_name)) as f:
        f.readline()
        for line in f:
            line = line.strip()
            parts = line.split('\t')
            question = parts[1]
            table_csv_file = parts[2]
            csv_table_file = os.path.join(dataset_path, table_csv_file)
            with open(csv_table_file, newline='') as csvfile:
                reader = csv.reader(csvfile)
                for line in reader:
                    col_list = [l.strip().replace('\n', ' ').replace('  ', '') for l in line]
                    break

            concat_output = [question]
            for col in col_list:
                concat_output.append('</s>')
                concat_output.append(col)

            output_data.append(' '.join(concat_output))

    with open(output_file, 'w') as outf:
        for entry in tqdm.tqdm(output_data):
            outf.write(f"{entry}\n")

    return


def collect_tabfact(tsv_data_file: str, data_path: str, output_file: str) -> None:
    tsv_data_file_path = os.path.join(data_path, tsv_data_file)
    csv_tables_folder_path = os.path.join(data_path, 'data/all_csv')
    output_data = []
    with open(tsv_data_file_path) as f:
        for line in f:
            line = line.strip()
            parts = line.split('\t')
            text = parts[-1]
            csv_tables_file = os.path.join(csv_tables_folder_path, parts[0])
            with open(csv_tables_file) as tf:
                header_line = tf.readline()
                col_list = header_line.split('#')

            concat_output = [text]
            for col in col_list:
                concat_output.append('</s>')
                concat_output.append(col)

            output_data.append(' '.join(concat_output))

    with open(output_file, 'w') as outf:
        for entry in tqdm.tqdm(output_data):
            outf.write(f"{entry}\n")

    return


if __name__ == "__main__":
    print("Collecting Spider...")
    collect_spider_wikisql(json_data_files=['./data/spider/train_spider.json', './data/spider/train_others.json'],
                           json_schema_file='./data/spider/tables.json',
                           output_file='./data/focusing/spider_train.txt')

    print("Collecting WikiSQL...")
    collect_spider_wikisql(json_data_files=['./data/wikisql/examples_train.json'],
                           json_schema_file='./data/wikisql/tables_train.json',
                           output_file='./data/focusing/wikisql_train.txt',
                           data_type='wikisql')

    print("Collecting WikiTableQuestions...")
    collect_wikitablequestions(dataset_path='../../data/focusing/non_sql_tabular_datasets/WikiTableQuestions',
                               tsv_data_file_name='data/training.tsv',
                               output_file='./data/focusing/wikitablequestions.txt')

    print("Collecting TabFact...")
    collect_tabfact(tsv_data_file='processed_datasets/tsv_data_horizontal/tabfact_all_data.tsv',
                    data_path='../../data/focusing/non_sql_tabular_datasets/Table-Fact-Checking',
                    output_file='./data/focusing/tabfact.txt')
