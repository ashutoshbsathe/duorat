export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000
export CUDA_VISIBLE_DEVICES=0 

# nohup python scripts/train.py \
#   --config configs/duorat/duorat-finetune-bert-large-only_spider.jsonnet \
#   --logdir logdir/duorat-finetune-bert-large-only_spider &> logdir/train-duorat-finetune-bert-large-only_spider.log &


# nohup python scripts/train.py \
#   --config configs/duorat/duorat-finetune-spider-bert-large-on-geo-oneshot.jsonnet \
#   --logdir logdir/duorat-finetune-spider-bert-large-on-geo-oneshot &> logdir/duorat-finetune-spider-bert-large-on-geo-oneshot.log &

# nohup python scripts/train.py \
#   --config configs/duorat/duorat-new-db-content-only_spider.jsonnet \
#   --logdir logdir/duorat-new-db-content-only_spider &> logdir/train-duorat-new-db-content-only_spider.log &

python scripts/train.py \
  --config configs/duorat/duorat-finetune-bert-large-only_spider.jsonnet \
  --logdir logdir/scratch/duorat-finetune-bert-large-only_spider #&> logdir/train-duorat-finetune-bert-large-only_spider.log &
