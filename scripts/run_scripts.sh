# *** duorat-dev (for debugging)
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-dev.jsonnet --logdir ./logdir/duorat-dev &> logdir/train-duorat-dev.log &

# *** duorat-bert (base, freezed) --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-bert.jsonnet --logdir ./logdir/duorat-freeze-bert-base &> logdir/train-duorat-freeze-bert-base.log &

# *** duorat-finetune-bert-base --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-base.jsonnet --logdir ./logdir/duorat-finetune-bert-base &> logdir/train-duorat-finetune-bert-base.log &

# *** duorat-finetune-bert-large --> ok
# OOM: reduce batch_size to 4
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --logdir ./logdir/duorat-finetune-bert-large &> logdir/train-duorat-finetune-bert-large.log &
python scripts/train.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --logdir ./logdir/duorat-finetune-bert-large --preprocess-only
python scripts/infer.py --logdir ./logdir/duorat-finetune-bert-large --section val --output ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.output  --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --section val --do-execute --inferred ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.output --output ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.eval
python scripts/interactive.py --logdir ./logdir/duorat-finetune-bert-large --config configs/duorat/duorat-finetune-bert-large.jsonnet --db-path ./tests/data/test_new_db.sqlite

# *** duorat-finetune-bert-large-attention-maps --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-large-attention-maps.jsonnet --logdir ./logdir/duorat-finetune-bert-large-attention-maps &> logdir/train-duorat-finetune-bert-large-attention-maps.log &

# *** duorat-new-db-content --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content &> logdir/train-duorat-new-db-content.log &
python scripts/infer.py --logdir ./logdir/duorat-new-db-content --section val --output ./logdir/duorat-new-db-content/val-duorat-new-db-content.output  --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-new-db-content/val-duorat-new-db-content.output --output ./logdir/duorat-new-db-content/val-duorat-new-db-content.eval
python scripts/interactive.py --logdir ./logdir/duorat-new-db-content --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./tests/data/test_new_db.sqlite

# w/ better model duorat-new-db-content-bs4-ac7
python scripts/infer.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --section val --output ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.output --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.output --output ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.eval
python scripts/interactive.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./tests/data/test_new_db.csv --schema-path ./tests/data/test_new_db.sqlite

# on train
python scripts/infer.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --section train --output ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.output --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section train --do-execute --inferred ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.output --output ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.eval

# w/ custom seed
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-seed1 --seed 1 &> logdir/train-duorat-new-db-content-seed1.log &

# serve
python scripts/serve.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/database --server-port 8000 --do-logging --log-append --do-sql-post-processing

# *** duorat-new-db-content-no-whole --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-no-whole.jsonnet --logdir ./logdir/duorat-new-db-content-no-whole &> logdir/train-duorat-new-db-content-no-whole.log &

# *** duorat-good-no-bert --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-good-no-bert.jsonnet --logdir ./logdir/duorat-good-no-bert &> logdir/train-duorat-good-no-bert.log &

# *** duorat-good-no-bert-no-from --> failed
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-good-no-bert-no-from.jsonnet --logdir ./logdir/duorat-good-no-bert-no-from &> logdir/train-duorat-good-no-bert-no-from.log &

# *** DATA AUGMENTATION

# Paraphrases by Back Translation
# EN-DE-EN (Google Translate)
python3 scripts/split_spider_by_db.py --aug-data train_spider_bt_aug_paraphrases.json,train_others_bt_aug_paraphrases.json --aug-suffix bt_para_aug

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug &> logdir/train-duorat-new-db-content-bt-para-aug.log &

