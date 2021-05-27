# *** Spider

# duorat-dev (for debugging)
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-dev.jsonnet --logdir ./logdir/duorat-dev &> logdir/train-duorat-dev.log &

# duorat-bert (base, freezed) --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-bert.jsonnet --logdir ./logdir/duorat-freeze-bert-base &> logdir/train-duorat-freeze-bert-base.log &

# duorat-finetune-bert-base --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-base.jsonnet --logdir ./logdir/duorat-finetune-bert-base &> logdir/train-duorat-finetune-bert-base.log &

# duorat-finetune-bert-large --> ok
# OOM: reduce batch_size to 4
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --logdir ./logdir/duorat-finetune-bert-large &> logdir/train-duorat-finetune-bert-large.log &
python scripts/train.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --logdir ./logdir/duorat-finetune-bert-large --preprocess-only
python scripts/infer.py --logdir ./logdir/duorat-finetune-bert-large --section val --output ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.output  --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-finetune-bert-large.jsonnet --section val --do-execute --inferred ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.output --output ./logdir/duorat-finetune-bert-large/val-duorat-finetune-bert-large.eval
python scripts/interactive.py --logdir ./logdir/duorat-finetune-bert-large --config configs/duorat/duorat-finetune-bert-large.jsonnet --db-path ./tests/data/test_new_db.sqlite

# duorat-finetune-bert-large-attention-maps --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-finetune-bert-large-attention-maps.jsonnet --logdir ./logdir/duorat-finetune-bert-large-attention-maps &> logdir/train-duorat-finetune-bert-large-attention-maps.log &

# duorat-new-db-content --> ok
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content &> logdir/train-duorat-new-db-content.log &
python scripts/infer.py --logdir ./logdir/duorat-new-db-content --section val --output ./logdir/duorat-new-db-content/val-duorat-new-db-content.output  --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-new-db-content/val-duorat-new-db-content.output --output ./logdir/duorat-new-db-content/val-duorat-new-db-content.eval
python scripts/interactive.py --logdir ./logdir/duorat-new-db-content --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./tests/data/test_new_db.sqlite

# w/ better model duorat-new-db-content-bs4-ac7
python scripts/infer.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --section val --output ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.output --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.output --output ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.eval
python scripts/interactive.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./tests/data/test_new_db.sqlite

# on train
python scripts/infer.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --section train --output ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.output --force --nproc 5 --beam-size 1
python scripts/eval.py --config configs/duorat/duorat-new-db-content.jsonnet --section train --do-execute --inferred ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.output --output ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.eval

# w/ custom seed
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-seed1 --seed 1 &> logdir/train-duorat-new-db-content-seed1.log &

# serve
CUDA_VISIBLE_DEVICES=1 python scripts/serve.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./data/database --server-port 8000 --do-logging --log-append --do-sql-post-processing &>./logdir/duorat-new-db-content-bs4-ac7/server_conn.log &

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

# Geo
cd ./data
bash scripts/download_michigan_no_docker.sh geo
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan.libsonnet --questions data/database/geo_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_geo.json
python scripts/evaluation_google.py --predictions_filepath ./logdir/duorat-new-db-content-bs4-ac7/inferred_geo.json --output_filepath ./logdir/duorat-new-db-content-bs4-ac7/output_geo.json --cache_filepath data/database/geo_test/geo_cache.json  --timeout 180
[NOT_EXIST] python scripts/filter_results.py ./logdir/duorat-new-db-content-bs4-ac7/output_geo.json

# Atis (failed)
bash scripts/download_michigan_no_docker.sh atis

# Academic (failed)
bash scripts/download_michigan_no_docker.sh academic

# Restaurants
bash scripts/download_michigan_no_docker.sh restaurants
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_restaurants.libsonnet --questions data/database/restaurants_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_restaurants.json

# Yelp
bash scripts/download_michigan_no_docker.sh yelp
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_yelp.libsonnet --questions data/database/yelp_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_yelp.json

# IMDB
bash scripts/download_michigan_no_docker.sh imdb
python scripts/infer_questions.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --data-config data/michigan_imdb.libsonnet --questions data/database/imdb_test/examples.json --output-google ./logdir/duorat-new-db-content-bs4-ac7/inferred_imdb.json

# Scholar
bash scripts/download_michigan_no_docker.sh scholar

# Advising
bash scripts/download_michigan_no_docker.sh advising

# *** Sparc

# duorat-sparc-dev
python scripts/train.py --config configs/duorat/duorat-sparc-dev.jsonnet --logdir ./logdir/duorat-sparc-dev --force-preprocess --force-train

# duorat-sparc-new-db-content (baseline)
# no interaction history in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-baseline.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-baseline --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-baseline.log &

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-baseline.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-baseline &> logdir/train-duorat-sparc-new-db-content-baseline.log1 &

# duorat-sparc-new-db-content

# train
# interaction history (source, 1) in the inputs
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content.log &
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-150k-steps.jsonnet --logdir ./logdir/duorat-sparc-new-db-content &> logdir/train-duorat-sparc-new-db-content.log1 &

CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --logdir ./logdir/duorat-sparc-new-db-content --section val --output ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output  --force

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content-eval-testsuite.output

[FAILED] CUDA_VISIBLE_DEVICES=3 python scripts/eval.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --section val --do-execute --inferred ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output --output ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.eval

# serve
# sparc
CUDA_VISIBLE_DEVICES=2 python scripts/serve.py --logdir ./logdir/duorat-sparc-new-db-content --config configs/duorat/duorat-sparc-new-db-content.jsonnet --db-path ./data/sparc/database --server-port 8200 --do-logging --log-append --do-sql-post-processing --log-file-name serve_followup.log &>./logdir/duorat-sparc-new-db-content/server_followup_conn.log &
cd text2sql-poc-ui-demo-jet9
node ./node_modules/@oracle/ojet-cli/ojet.js serve --server-port=8300 --livereload-port 36729

# testsuite eval
# quick test
python3 evaluation.py --gold ./evaluation_examples/gold.txt --pred ./evaluation_examples/predict.txt --db ./database  --etype all  --progress_bar_for_each_datapoint

# run1
# testsuite execution accuracy without values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value  --progress_bar_for_each_datapoint

# testsuite execution accuracy with values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content-eval-testsuite.output --db ./database --etype exec --progress_bar_for_each_datapoint

# interaction history (source, 1) in the inputs (run2)
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-run2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-run2.log &

# interaction history (source, 1) in the inputs (run3)
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-run3 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-run3.log &

# interaction history (source, 2) in the inputs
CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-int2.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-int2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-int2.log &

CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-int2.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-int2 &> logdir/train-duorat-sparc-new-db-content-int2.log1 &

# interaction history (target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-dev-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-dev-target-interaction --force-preprocess --force-train

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-target-interaction --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-target-interaction.log &

CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --logdir ./logdir/duorat-sparc-new-db-content-target-interaction --section val --output ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth.output  --force

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-eval-testsuite.output --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-eval-testsuite.output

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value --progress_bar_for_each_datapoint

# run2
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-target-interaction-run2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-target-interaction-run2.log &

# run3
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-target-interaction-run3 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-target-interaction-run3.log &

# interaction history (source&target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-source-target-interaction --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-source-target-interaction.log &

# run2
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-source-target-interaction-run2 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-source-target-interaction-run2.log &

# run3
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-source-target-interaction-run3 --force-preprocess --force-train &> logdir/train-duorat-sparc-new-db-content-source-target-interaction-run3.log &

# *** CoSQL

# interaction history (target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-target-interaction --force-preprocess --force-train &> logdir/train-duorat-cosql-new-db-content-target-interaction.log &

CUDA_VISIBLE_DEVICES=0 python scripts/infer.py --logdir ./logdir/duorat-cosql-new-db-content-target-interaction --section val --output ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth.output  --force

python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth-eval-testsuite.output "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

# interaction history (source&target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-source-target-interaction --force-preprocess --force-train &> logdir/train-duorat-cosql-new-db-content-source-target-interaction.log &

# duorat-cosql-dev
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-cosql-dev.jsonnet --logdir ./logdir/duorat-cosql-dev --force-preprocess --force-train &> logdir/train-duorat-cosql-dev.log &

# duorat-cosql-new-db-content
# interaction history (1) in the inputs

# run1
# train
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-cosql-new-db-content --force-preprocess --force-train &> logdir/train-cosql-new-db-content.log &

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content-150k-steps.jsonnet --logdir ./logdir/duorat-cosql-new-db-content &> logdir/train-cosql-new-db-content.log1 &

# infer
CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --logdir ./logdir/duorat-cosql-new-db-content --section val --output ./logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content.output  --force

# eval
python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content-eval-testsuite.output "I have left the chat"

# testsuite execution accuracy without values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value  --progress_bar_for_each_datapoint

# testsuite execution accuracy with values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content-eval-testsuite.output --db ./database --etype exec --progress_bar_for_each_datapoint

# run2
CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-run2 --force-preprocess --force-train &> logdir/train-cosql-new-db-content-run2.log &

CUDA_VISIBLE_DEVICES=2 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content-150k-steps.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-run2 &> logdir/train-cosql-new-db-content-run2.log1 &

# infer
CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --logdir ./logdir/duorat-cosql-new-db-content-run2 --section val --output ./logdir/duorat-cosql-new-db-content-run2/val-duorat-cosql-new-db-content.output  --force

# eval
python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-run2/val-duorat-cosql-new-db-content.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-run2/val-duorat-cosql-new-db-content-eval-testsuite.output "I have left the chat"

# testsuite execution accuracy without values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-run2/val-duorat-cosql-new-db-content-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value  --progress_bar_for_each_datapoint

# testsuite execution accuracy with values
python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-run2/val-duorat-cosql-new-db-content-eval-testsuite.output --db ./database --etype exec --progress_bar_for_each_datapoint

# run3
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-run3 --force-preprocess --force-train &> logdir/train-cosql-new-db-content-run3.log &

CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content-150k-steps.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-run3 &> logdir/train-cosql-new-db-content-run3.log1 &

# *** Learning curve for Spider/Sparc/CoSQL

# Spider
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-5p --train-sample-ratio 5
sh run_learning_curve_slurm.sh spider 5

# Sparc
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-5p --train-sample-ratio 5
sh run_learning_curve_slurm.sh sparc 5

# CoSQL
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-5p --train-sample-ratio 5
sh run_learning_curve_slurm.sh cosql 5

# *** Joint Spider+Sparc+CoSQL
# dev (for debugging)
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-sparc-cosql-dev.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-dev --force-preprocess --force-train &> logdir/train-duorat-spider-sparc-cosql-dev.log &

# train
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content --force-preprocess --force-train &> logdir/train-duorat-spider-sparc-cosql-new-db-content.log &

# infer
CUDA_VISIBLE_DEVICES=2 python scripts/infer.py --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content --output ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content.output  --force
# outputs: val-duorat-spider-sparc-cosql-new-db-content.output{.Spider,.Sparc,.CoSQL}

# run4
CUDA_VISIBLE_DEVICES=0 python scripts/infer.py --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-run4 --output ./logdir/duorat-spider-sparc-cosql-new-db-content-run4/val-duorat-spider-sparc-cosql-new-db-content.output  --force
# outputs: val-duorat-spider-sparc-cosql-new-db-content.output{.Spider,.Sparc,.CoSQL}

# interaction history (target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction --force-preprocess --force-train &> logdir/train-duorat-spider-sparc-cosql-new-db-content-target-interaction.log &

# interaction history (source&target, 1) in the inputs
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction --force-preprocess --force-train &> logdir/train-duorat-spider-sparc-cosql-new-db-content-source-target-interaction.log &

# eval w/ TestSuite
# Spider
python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content.output.Spider ./data/spider/dev.json ./data/spider/dev_gold.sql /tmp/dump_file.txt ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.Spider

# Sparc

python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content.output.Sparc ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.Sparc

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.Sparc --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value  --progress_bar_for_each_datapoint

# run4
python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content-run4/val-duorat-spider-sparc-cosql-new-db-content.output.Sparc ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-spider-sparc-cosql-new-db-content-run4/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.Sparc

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-cosql-new-db-content-run4/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.Sparc --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value  --progress_bar_for_each_datapoint

# CoSQL
python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content.output.CoSQL ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.CoSQL "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-cosql-new-db-content/val-duorat-spider-sparc-cosql-new-db-content-eval-testsuite.output.CoSQL --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value  --progress_bar_for_each_datapoint

# 200K steps
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-200k-steps.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content &>logdir/train-duorat-spider-sparc-cosql-new-db-content-200k-steps.log &

# *** User intent prediction
python convert_to_fasttext_format.py cosql_train.json cosql_train_intent.fasttext
python convert_to_fasttext_format.py cosql_dev.json cosql_dev_intent.fasttext
python scripts/build_text_classifier.py /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/user_intent_prediction/cosql_train_intent.fasttext /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/user_intent_prediction/cosql_dev_intent.fasttext /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/user_intent_prediction/cosql_dev_intent.fasttext exp/models/cosql_intent_model.bin
# (1503, 0.8569527611443779, 0.8293625241468127)
# Accuracy on test split: 0.8380889183808892

# *** WikiSQL
# create dataset
bash scripts/create_wikisql_dataset.sh

# dev (for debugging)
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-wikisql-dev.jsonnet --logdir ./logdir/duorat-wikisql-dev --force-preprocess --force-train &> logdir/train-duorat-wikisql-dev.log &

# train
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-wikisql-new-db-content.jsonnet --logdir ./logdir/duorat-wikisql-new-db-content --force-preprocess --force-train &> logdir/train-duorat-wikisql-new-db-content.log &

# infer

# *** Extracting NL2SQL templates
# Spider

# w/o OP & SC denotations
CUDA_VISIBLE_DEVICES=0 python scripts/data_aug/extract_templates.py --sql-keyword-list-file ./scripts/data_aug/sql_keywords.txt --duorat-prediction-file ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.eval --duorat-config-file ./configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --template-output-file ./logdir/duorat-new-db-content-bs4-ac7/train_spider.nl2sql_templates_no_sc_op --output-in-csv --with-stemming

# w/ OP & SC denotations
python scripts/data_aug/extract_templates.py --sql-keyword-list-file ./scripts/data_aug/sql_keywords.txt --duorat-prediction-file ./logdir/duorat-new-db-content-bs4-ac7/train-duorat-new-db-content-bs4-ac7.eval --duorat-config-file ./configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --template-output-file ./logdir/duorat-new-db-content-bs4-ac7/train_spider.nl2sql_templates --output-in-csv --with-stemming --with-op-denotation --with-sc-denotation

# *** Spider w/ extra schema descriptions
python3 scripts/split_spider_by_db.py --tables-path tables_descriptions.json

# train & test w/ additional schema descriptions
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-extra-schema-descriptions.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-extra-schema-descriptions --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-extra-schema-descriptions.log &

# run2
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-extra-schema-descriptions.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-extra-schema-descriptions-run2 --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-extra-schema-descriptions-run2.log &

# run3
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-extra-schema-descriptions.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-extra-schema-descriptions-run3 --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-extra-schema-descriptions-run3.log &

# *** Spider w/ inferred column types
python3 scripts/split_spider_by_db.py --tables-path tables_inferred_col_types.json

# train & test w/ inferred column types
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-inferred-col-types.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-inferred-col-types --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-inferred-col-types.log &

# run2
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-inferred-col-types.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-inferred-col-types-run2 --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-inferred-col-types-run2.log &

# run3
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-inferred-col-types.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-inferred-col-types-run3 --force-preprocess --force-train &> logdir/train-duorat-spider-new-db-content-with-inferred-col-types-run3.log &

# test only w/ additional schema descriptions
CUDA_VISIBLE_DEVICES=3 python scripts/infer.py --config configs/duorat/duorat-spider-new-db-content-with-extra-schema-descriptions.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7-with-extra-schema-descriptions/ --section val --output ./logdir/duorat-new-db-content-bs4-ac7-with-extra-schema-descriptions/val-duorat-new-db-content-bs4-ac7-with-extra-schema-descriptions.output --force

# *** Inference latency

# Spider
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content.output

# Sparc
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-sparc-new-db-content.jsonnet --logdir ./logdir/duorat-sparc-new-db-content --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-sparc-new-db-content/val-duorat-sparc-new-db-content.output &> ./logdir/duorat-sparc-new-db-content/gpu_latency.log

# Sparc w/ target interaction (prediction)
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-sparc-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction.output &> ./logdir/duorat-sparc-new-db-content-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-eval-testsuite.output

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-eval-testsuite.output --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# Sparc w/ target interaction (groundtruth)
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-sparc-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-io.output --use-groundtruths

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-io.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-io-eval-testsuite.output

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-io-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-sparc-new-db-content-target-interaction/val-duorat-sparc-new-db-content-target-interaction-groundtruth-io-eval-testsuite.output --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# Sparc w/ source&target interaction (groundtruth)
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-sparc-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-source-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-groundtruth.output --use-groundtruths

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-groundtruth.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-groundtruth-eval-testsuite.output

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-groundtruth-eval-testsuite.output --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# Sparc w/ source&target interaction (prediction)
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-sparc-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-sparc-new-db-content-source-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction.output

python scripts/get_testsuite_preds.py ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction.output ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-eval-testsuite.output

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-sparc-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-eval-testsuite.output --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# CoSQL
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-cosql-new-db-content.jsonnet --logdir ./logdir/duorat-cosql-new-db-content --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content.output --ignored-patterns "I have left the chat" &> ./logdir/duorat-cosql-new-db-content/gpu_latency.log

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-cosql-new-db-content/val-duorat-cosql-new-db-content-eval-testsuite.output --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# CoSQL w/ target interaction (groundtruth)
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth.output --ignored-patterns "I have left the chat" --use-groundtruths &> ./logdir/duorat-cosql-new-db-content-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth-eval-testsuite.output "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-groundtruth-eval-testsuite.output --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# CoSQL w/ target interaction (prediction)
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction.output --ignored-patterns "I have left the chat" &> ./logdir/duorat-cosql-new-db-content-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-eval-testsuite.output "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-cosql-new-db-content-target-interaction/val-duorat-cosql-new-db-content-target-interaction-eval-testsuite.output --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# CoSQL w/ source&target interaction (groundtruth)
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-source-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-groundtruth.output --ignored-patterns "I have left the chat" --use-groundtruths &> ./logdir/duorat-cosql-new-db-content-source-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-groundtruth.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-groundtruth-eval-testsuite.output "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-groundtruth-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-groundtruth-eval-testsuite.output --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# CoSQL w/ source&target interaction (prediction)
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-cosql-new-db-content-source-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction.output --ignored-patterns "I have left the chat" &> ./logdir/duorat-cosql-new-db-content-source-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction.output ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-eval-testsuite.output "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-eval-testsuite.output --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-cosql-new-db-content-source-target-interaction/val-duorat-cosql-new-db-content-source-target-interaction-eval-testsuite.output --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# Spider + Sparc + CoSQL w/ target interaction (prediction)

# Sparc
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction.output.sparc &> ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction.output.sparc ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.sparc

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.sparc --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.sparc --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# CoSQL
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction.output.cosql --ignored-patterns "I have left the chat" &> ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction.output.cosql ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.cosql "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.cosql --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-spider-sparc-cosql-new-db-content-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-target-interaction-eval-testsuite.output.cosql --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# Spider + Sparc + CoSQL w/ source&target interaction (prediction)

# Sparc
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction --data-type Sparc --db-folder-path ./data/sparc/database/ --eval-file ./data/sparc/dev.json --output-eval-file ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction.output.sparc &> ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction.output.sparc ./data/sparc/dev.json ./data/sparc/dev_gold.txt /tmp/dump_file.txt ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-eval-testsuite.output.sparc

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/dev_gold_fixed.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction-eval-testsuite.output.sparc --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/sparc/tables.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/sparc/dev_gold.txt --pred ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-sparc-new-db-content-source-target-interaction-eval-testsuite.output.sparc --etype match --db ./data/sparc/database/ --table ./data/sparc/tables.json

# CoSQL
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-spider-sparc-cosql-new-db-content-source-target-interaction.jsonnet --logdir ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction --data-type CoSQL --db-folder-path ./data/cosql/database/ --eval-file ./data/cosql/sql_state_tracking/cosql_dev.json --output-eval-file ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction.output.cosql --ignored-patterns "I have left the chat" &> ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/gpu_latency.log

python scripts/get_testsuite_preds.py ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction.output.cosql ./data/cosql/sql_state_tracking/cosql_dev_fixed.json ./data/cosql/sql_state_tracking/dev_gold_fixed.txt ./data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt  ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction-eval-testsuite.output.cosql "I have left the chat"

python3 evaluation.py --gold /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/sql_state_tracking/dev_gold_fixed_filtered.txt --pred /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/logdir/duorat-spider-sparc-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction-eval-testsuite.output.cosql --db ./database --etype all --table /mnt/shared/vchoang/works/projects/oda/text2sql/code/duorat/data/cosql/tables_fixed.json --plug_value --progress_bar_for_each_datapoint

python2 ./third_party/sparc/evaluation.py --gold ./data/cosql/sql_state_tracking/dev_gold_fixed.txt --pred ./logdir/duorat-spider-sparc-cosql-new-db-content-source-target-interaction/val-duorat-spider-sparc-cosql-new-db-content-source-target-interaction-eval-testsuite.output.cosql --etype match --db ./data/cosql/database/ --table ./data/cosql/tables.json

# *** Experiments for focusing idea

# ** Use Spider synthetic data from tensor2struct
#python collect_spider_synthetic_data_tensor2struct.py --tensor2struct-synthetic-data-file
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data spider_synthetic_data_tensor2struct.json --aug-suffix spider_synthetic_data_tensor2struct

# original training data + synthetic data

# train w/ synthetic data --> finetune w/ original data

python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-synthetic-data-tensor2struct.jsonnet --logdir ./logdir/duorat-spider-new-db-content-synthetic-data-tensor2struct --force-preprocess --force-train

# ** Use synthetic data generated by template-based SCFG

# get synthetic data from @Philip Arthur
python scripts/data_aug/collect_synthetic_data_from_tsv_files.py --tsv-files-folder-path /mnt/shared/parthur/experiments/nl2sql/output/data/v1/spider --output-data-file ./data/spider/train_synthetic_data_by_template_scfg_100s.json --samples-by-level 100
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data train_synthetic_data_by_template_scfg_100s.json --aug-suffix spider_synthetic_data_template_scfg_100s\

# train w/ synthetic data --> finetune w/ original data
# train w/ synthetic data
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-synthetic-data-template-scfg-100s.jsonnet --logdir ./logdir/duorat-spider-new-db-content-synthetic-data-template-scfg-100s --force-preprocess --force-train
# finetune w/ original data
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-initialized-from-synthetic-data-template-scfg-100s.jsonnet --logdir ./logdir/duorat-spider-new-db-content-initialized-from-synthetic-data-template-scfg-100s --force-preprocess --force-train

# train w/ mix of original and synthetic data
# w/ batch balancing (to be checked)
CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-original-plus-synthetic-data-batch-balancing.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-original-plus-synthetic-data-batch-balancing --force-preprocess --force-train &>./logdir/train-duorat-spider-new-db-content-with-original-plus-synthetic-data-batch-balancing.log &

# w/o batch balancing
CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-with-original-plus-synthetic-data.jsonnet --logdir ./logdir/duorat-spider-new-db-content-with-original-plus-synthetic-data --force-preprocess --force-train &>././logdir/train-duorat-spider-new-db-content-with-original-plus-synthetic-data.log &

# *** Experiments for adding dev data into training data

# train on original data but evaluate on splitted val data
# 5-5
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_split_5_5_half2.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev55-duorat-new-db-content.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev55-duorat-new-db-content.output --gold-txt-file ./data/spider/dev_split_5_5_gold.txt --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev55-duorat-new-db-content.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_split_5_5_gold.txt --pred ./logdir/duorat-new-db-content-bs4-ac7/val-dev55-duorat-new-db-content.output.txt --etype match --db ./data/database --table ./data/spider/tables.json
# 4-6
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_split_4_6_half2.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev46-duorat-new-db-content.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev46-duorat-new-db-content.output --gold-txt-file ./data/spider/dev_split_4_6_gold.txt --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev46-duorat-new-db-content.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_split_4_6_gold.txt --pred ./logdir/duorat-new-db-content-bs4-ac7/val-dev46-duorat-new-db-content.output.txt --etype match --db ./data/database --table ./data/spider/tables.json
# 3-7
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_split_3_7_half2.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev37-duorat-new-db-content.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev37-duorat-new-db-content.output --gold-txt-file ./data/spider/dev_split_3_7_gold.txt --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev37-duorat-new-db-content.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_split_3_7_gold.txt --pred ./logdir/duorat-new-db-content-bs4-ac7/val-dev37-duorat-new-db-content.output.txt --etype match --db ./data/database --table ./data/spider/tables.json
# 2-8
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_split_2_8_half2.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev28-duorat-new-db-content.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev28-duorat-new-db-content.output --gold-txt-file ./data/spider/dev_split_2_8_gold.txt --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-dev28-duorat-new-db-content.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_split_2_8_gold.txt --pred ./logdir/duorat-new-db-content-bs4-ac7/val-dev28-duorat-new-db-content.output.txt --etype match --db ./data/database --table ./data/spider/tables.json

# split dev randomly
# Spider

# 5-5
python scripts/split_dev.py --dev-json-file ./data/spider/dev.json --split-json-file-prefix ./data/spider/dev_split_5_5 --split-rate 0.5
python3 scripts/split_spider_by_db.py --examples-paths 'train_spider.json,train_others.json,dev_split_5_5_half1.json' --default-example-file-name examples_plus_dev55.json
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data dev_split_5_5_half2.json --aug-suffix dev_split_5_5

CUDA_VISIBLE_DEVICES=0 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-train-plus-dev55.jsonnet --logdir ./logdir/duorat-spider-new-db-content-train-plus-dev55 --force-preprocess --force-train &>./logdir/train-duorat-spider-new-db-content-train-plus-dev55.log &

# 2-8
CUDA_VISIBLE_DEVICES=3 python scripts/infer_one.py --config configs/duorat/duorat-spider-new-db-content-train-plus-dev55.jsonnet --logdir ./logdir/duorat-spider-new-db-content-train-plus-dev55 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_split_5_5_half2.json --output-eval-file ./logdir/duorat-spider-new-db-content-train-plus-dev55/val-dev55-duorat-new-db-content.output

# 4-6
python scripts/split_dev.py --dev-json-file ./data/spider/dev.json --split-json-file-prefix ./data/spider/dev_split_4_6 --split-rate 0.4
python3 scripts/split_spider_by_db.py --examples-paths 'train_spider.json,train_others.json,dev_split_4_6_half1.json' --default-example-file-name examples_plus_dev46.json
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data dev_split_4_6_half2.json --aug-suffix dev_split_4_6

CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-train-plus-dev46.jsonnet --logdir ./logdir/duorat-spider-new-db-content-train-plus-dev46 --force-preprocess --force-train &>./logdir/train-duorat-spider-new-db-content-train-plus-dev46.log &

# 3-7
python scripts/split_dev.py --dev-json-file ./data/spider/dev.json --split-json-file-prefix ./data/spider/dev_split_3_7 --split-rate 0.3
python3 scripts/split_spider_by_db.py --examples-paths 'train_spider.json,train_others.json,dev_split_3_7_half1.json' --default-example-file-name examples_plus_dev37.json
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data dev_split_3_7_half2.json --aug-suffix dev_split_3_7

CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-train-plus-dev37.jsonnet --logdir ./logdir/duorat-spider-new-db-content-train-plus-dev37 --force-preprocess --force-train &>./logdir/train-duorat-spider-new-db-content-train-plus-dev37.log &

# 2-8
python scripts/split_dev.py --dev-json-file ./data/spider/dev.json --split-json-file-prefix ./data/spider/dev_split_2_8 --split-rate 0.2
python3 scripts/split_spider_by_db.py --examples-paths 'train_spider.json,train_others.json,dev_split_2_8_half1.json' --default-example-file-name examples_plus_dev28.json
python3 scripts/split_spider_by_db.py --examples-paths '' --aug-data dev_split_2_8_half2.json --aug-suffix dev_split_2_8

CUDA_VISIBLE_DEVICES=3 python scripts/train.py --config configs/duorat/duorat-spider-new-db-content-train-plus-dev28.jsonnet --logdir ./logdir/duorat-spider-new-db-content-train-plus-dev28 --force-preprocess --force-train &>./logdir/train-duorat-spider-new-db-content-train-plus-dev28.log &

# *** Get prediction errors

# db-id=concert_singer
python scripts/get_output_errors.py ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.eval ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.errors.concert_singer concert_singer

# db-id=pets_1
python scripts/get_output_errors.py ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.eval ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.errors.pets_1 pets_1

# db-id=car_1
python scripts/get_output_errors.py ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.eval ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-bs4-ac7.errors.car_1 car_1

# *** CustomNER for NL2SQL

# run interactive mode for error analysis
CUDA_VISIBLE_DEVICES=0 python scripts/interactive.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./data/database/concert_singer/concert_singer.sqlite --schema-path ./data/database/concert_singer/tables.json

CUDA_VISIBLE_DEVICES=0 python scripts/interactive.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./data/database/pets_1/pets_1.sqlite --schema-path ./data/database/pets_1/tables.json

CUDA_VISIBLE_DEVICES=0 python scripts/interactive.py --logdir ./logdir/duorat-new-db-content-bs4-ac7 --config configs/duorat/duorat-new-db-content.jsonnet --db-path ./data/database/car_1/car_1.sqlite --schema-path ./data/database/car_1/tables.json

# get SLML outputs
python scripts/get_slml_outputs.py --duorat-config-file ./configs/duorat/duorat-new-db-content.jsonnet --input-file ./data/spider/dev.json  --output-file ./data/spider/dev_with_unsup_slml.json

CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_with_unsup_slml.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-slml.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-slml.output --gold-txt-file ./data/spider/dev_gold.sql --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-slml.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_gold.sql --pred ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-slml.output.txt --etype match --db ./data/database --table ./data/spider/tables.json

# w/ human-corrected SLML
CUDA_VISIBLE_DEVICES=0 python scripts/infer_one.py --config configs/duorat/duorat-new-db-content.jsonnet --logdir ./logdir/duorat-new-db-content-bs4-ac7 --db-folder-path ./data/database/ --eval-file ./data/spider/dev_with_human_slml.json --output-eval-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-human-slml.output
python scripts/get_preds_from_json_file.py --preds-json-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-human-slml.output --gold-txt-file ./data/spider/dev_gold.sql --output-preds-txt-file ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-human-slml.output.txt
python -m third_party.spider.evaluation --gold ./data/spider/dev_gold.sql --pred ./logdir/duorat-new-db-content-bs4-ac7/val-duorat-new-db-content-with-human-slml.output.txt --etype match --db ./data/database --table ./data/spider/tables.json