export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export TOKENIZERS_PARALLELISM=true

SMBOP_DIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/SmBop/
DATA_DIR=/home/ashutosh/HDD/MachineLearning/ComplexMNIST/ms_rnd1/split_0/world_1/
TABLES_PATH=$SMBOP_DIR/dataset/tables.json
DATABASE_PATH=$SMBOP_DIR/dataset/database

logdir_NAME=duorat-finetune-bert-large-only_spider

python scripts/infer_from_json.py \
    --config logdir/duorat-finetune-bert-large-only_spider/config-20210420T165015.json \
	--logdir logdir/$logdir_NAME \
	--questions $DATA_DIR/test.json \
	--output-spider tmp/spider.json \
	--tables-path $TABLES_PATH \
	--database-path $DATABASE_PATH
