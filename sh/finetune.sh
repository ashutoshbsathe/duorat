export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export CUDA_VISIBLE_DEVICES=0
export TOKENIZERS_PARALLELISM=true

DB_ID=world_1 

METHOD_NAME=proposed
METHOD_FOLDER="train_as_dev=0.1;new_model;prop_n=10,k=4,tree=1e-3,thresh=20,filter=1;sql2nl_n=4,k=1,filter=0;"

DATA_DIR=/home/ashutosh/HDD/MachineLearning/ComplexMNIST/ms_rnd1/new/split_0/world_1
SMBOP_DIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/SmBop

GEN_DATA_DIR=/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/ms_rnd1/finetune_pipeline/$DB_ID/$METHOD_FOLDER/
python scripts/my_finetune.py \
  --config configs/duorat/duorat-finetune-spider-bert-large-on-sql2text.jsonnet \
  --logdir $GEN_DATA_DIR/$DB_ID.$METHOD_FOLDER.logdir/ \
  --tables-path $SMBOP_DIR/dataset/tables.json \
  --train-examples-path $GEN_DATA_DIR/train.json \
  --val-examples-path $GEN_DATA_DIR/val.json
