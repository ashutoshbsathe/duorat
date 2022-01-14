export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000

SMBOP_DIR=/mnt/infonas/data/awasthi/semantic_parsing/smbop
DATA_DIR=$SMBOP_DIR/pickles/spider_val_cbr_splits_20/split_0/world_1
TABLES_PATH=$SMBOP_DIR/dataset/tables.json
DATABASE_PATH=$SMBOP_DIR/dataset/database

logdir_NAME=duorat-finetune-bert-large-only_spider

python scripts/infer_from_json.py \
	--logdir logdir/$logdir_NAME \
	--questions $DATA_DIR/test.json \
	--output-spider tmp/spider.json \
	--tables-path $TABLES_PATH \
	--database-path $DATABASE_PATH