# coding=utf-8
#~/usr/bin/env bash

# This script must be executed in the duorat's root dir.

MICHIGAN_GITHUB=https://raw.githubusercontent.com/jkkummerfeld/text2sql-data/master
CODE=$PWD
DATA_DIR=${CODE}/data

# WikiSQL
function go_wikisql {
    mkdir ${DATA_DIR}/wikisql && cd ${DATA_DIR}/wikisql
    wget $MICHIGAN_GITHUB/data/wikisql.json.bz2 || exit
    bzip2 -d wikisql.json.bz2
    python $CODE/scripts/convert_from_michigan.py --input wikisql.json --db-id wikisql_train --output examples_train.json\
        --split train
    python $CODE/scripts/convert_from_michigan.py --input wikisql.json --db-id wikisql_dev --output examples_dev.json\
        --split dev
    python $CODE/scripts/convert_from_michigan.py --input wikisql.json --db-id wikisql_test --output examples_test.json\
        --split test
    git clone https://github.com/salesforce/WikiSQL.git || exit
    cd WikiSQL
    bzip2 -d data.tar.bz2
    tar -xvf data.tar
    cd ..
    cd -

    python $CODE/scripts/get_tables_new.py\
        ${DATA_DIR}/wikisql/WikiSQL/data/train.db\
        ${DATA_DIR}/wikisql/tables_train.json
    python $CODE/scripts/get_tables_new.py\
        ${DATA_DIR}/wikisql/WikiSQL/data/dev.db\
        ${DATA_DIR}/wikisql/tables_dev.json
    python $CODE/scripts/get_tables_new.py\
        ${DATA_DIR}/wikisql/WikiSQL/data/test.db\
        ${DATA_DIR}/wikisql/tables_test.json
}

rm -rf $DATA_DIR/wikisql
go_wikisql