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

# run1
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug &> logdir/train-duorat-new-db-content-bt-para-aug.log &
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug-150k-steps.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug &> logdir/train-duorat-new-db-content-bt-para-aug-150k-steps.log &

# run2
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug-run2 &> logdir/train-duorat-new-db-content-bt-para-aug-run2.log &
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug-150k-steps.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug-run2 &> logdir/train-duorat-new-db-content-bt-para-aug-run2-150k-steps.log &

# run3
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug-run3 &> logdir/train-duorat-new-db-content-bt-para-aug-run3.log &
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content-bt-para-aug-150k-steps.jsonnet --logdir ./logdir/duorat-new-db-content-bt-para-aug-run3 &> logdir/train-duorat-new-db-content-bt-para-aug-run3-150k-steps.log &

python scripts/collect_training_data_from_oda_para_dm.py /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/spider/paraphrasing_results.csv /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/spider/train_oda_dm_para.json

# Paraphrases by Manual Paraphrase Collection
python3 scripts/split_spider_by_db.py --aug-data train_oda_dm_para.json --aug-suffix oda_dm_para_aug

# *** Evaluate on other semantic parsing datasets

# geo
bash scripts/download_michigan_no_docker.sh geo
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan.libsonnet --questions data/database/geo_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_geo.json
python scripts/evaluation_google.py --predictions_filepath ./logdir/duorat-new-db-content-bs4-ac7/inferred_geo.json --output_filepath ./logdir/duorat-new-db-content-bs4-ac7/output_geo.json --cache_filepath data/database/geo_test/geo_cache.json  --timeout 180
[NOT_EXIST] python scripts/filter_results.py ./logdir/duorat-new-db-content-bs4-ac7/output_geo.json

# atis (failed)

# academic (failed)

# restaurants
bash scripts/download_michigan_no_docker.sh restaurants
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_restaurants.libsonnet --questions data/database/restaurants_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_restaurants.json

# yelp
bash scripts/download_michigan_no_docker.sh yelp
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_yelp.libsonnet --questions data/database/yelp_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_yelp.json

# imdb
bash scripts/download_michigan_no_docker.sh imdb
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_imdb.libsonnet --questions data/database/imdb_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_imdb.json

# scholar

# advising

# wikisql

# *** Sparc

# duorat-sparc-dev
python scripts/train.py --config configs/duorat/duorat-sparc-dev.jsonnet --logdir ./logdir/duorat-sparc-dev --force-preprocess --force-train

# duorat-sparc-new-db-content (baseline)
# no interaction history in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-baseline.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-baseline --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-baseline.log &

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-baseline.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-baseline &> logdir/train-duorat-sparc-new-db-content-baseline.log1 &

# duorat-sparc-new-db-content
# interaction history (1) in the inputs
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content.log &
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-150k-steps.jsonnet --logdir ./logdir/duorat-sparc-new-db-content &> logdir/train-duorat-sparc-new-db-content.log1 &

CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --logdir ./logdir/duorat-sparc-new-db-content --section val --output ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output  --force

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output ./data/sparc/dev.json ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content-eval-testsuite.output

[FAILED] CUDA_VISIBLE_DEVICES=3 python scripts/eval.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output --output ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.eval

# testsuite eval
# test
python3 evaluation.py --gold ./evaluation_examples/gold.txt --pred ./evaluation_examples/predict.txt --db ./database  --etype all  --progress_bar_for_each_datapoint
# run1
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content-eval-testsuite.output --db ./database --etype exec  --progress_bar_for_each_datapoint

# interaction history (1) in the inputs (run2)
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-run2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-run2.log &

# interaction history (1) in the inputs (run3)
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-run3 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-run3.log &

# interaction history (2) in the inputs
CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-int2.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-int2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-int2.log &

CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-int2.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-int2 &> logdir/train-duorat-sparc-new-db-content-int2.log1 &


