export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export CUDA_VISIBLE_DEVICES=0


SMBOP_DIR=/mnt/infonas/data/awasthi/semantic_parsing/smbop
DATA_DIR=$SMBOP_DIR/pickles/spider_val_cbr_splits_20/split_0/world_1

python scripts/my_finetune.py \
  --config configs/duorat/duorat-finetune-spider-bert-large-on-sql2text.jsonnet \
  --logdir logdir/scratch/check \
  --tables-path $SMBOP_DIR/dataset/tables.json \
  --train-examples-path $DATA_DIR/train.json \
  --val-examples-path $DATA_DIR/train.json
