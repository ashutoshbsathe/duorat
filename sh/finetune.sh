export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export CUDA_VISIBLE_DEVICES=0
export TOKENIZERS_PARALLELISM=true

DATA_DIR=/home/ashutosh/HDD/MachineLearning/ComplexMNIST/ms_rnd1/new/split_0/world_1
SMBOP_DIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/SmBop

python scripts/my_finetune.py \
  --config configs/duorat/duorat-finetune-spider-bert-large-on-sql2text.jsonnet \
  --logdir logdir/scratch/check \
  --tables-path $SMBOP_DIR/dataset/tables.json \
  --train-examples-path $DATA_DIR/train.json \
  --val-examples-path $DATA_DIR/val.json
