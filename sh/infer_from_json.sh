export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export TOKENIZERS_PARALLELISM=true
export TRANSFORMERS_OFFLINE=1

DB_ID=world_1

METHOD_NAME=proposed

LOGDIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/ms_rnd1/finetune_pipeline/expt_proposed_duorat/$DB_ID/$METHOD_NAME/$DB_ID.$METHOD_NAME.logdir/
SMBOP_DIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/SmBop/
DATA_DIR=/home/ashutosh/HDD/MachineLearning/ComplexMNIST/ms_rnd1/new/split_0/$DB_ID/
TABLES_PATH=$SMBOP_DIR/dataset/tables.json
DATABASE_PATH=$SMBOP_DIR/dataset/database


#--questions /home/ashutosh/HDD/IITB/Sem_1/MS_RnD/ms_rnd1/finetune_pipeline/expt_proposed_duorat/world_1/proposed/finetune-dev.json \
#--logdir $LOGDIR \
python scripts/infer_from_json.py \
    --config logdir/duorat-finetune-bert-large-only_spider/config-20210420T165015.json \
    --logdir logdir/duorat-finetune-bert-large-only_spider/ \
    --questions $DATA_DIR/test.json \
	--output-spider tmp/$DB_ID.$METHOD_NAME.raw_pred.sql \
	--tables-path $TABLES_PATH \
	--database-path $DATABASE_PATH

sed 's/"\([^"]*\)"/ "\1" /g' < tmp/$DB_ID.$METHOD_NAME.raw_pred.sql > tmp/$DB_ID.$METHOD_NAME.fixed_pred.sql
