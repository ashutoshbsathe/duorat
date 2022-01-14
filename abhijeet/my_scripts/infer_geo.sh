export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05
export CORENLP_SERVER_PORT=9000

# logdir_NAME=duorat-finetune-bert-large-only_spider
# python scripts/infer_questions.py \
# 	--logdir logdir/$logdir_NAME \
# 	--data-config data/michigan.libsonnet \
# 	--questions data/database/geo_test/examples.json \
# 	--output-google logdir/$logdir_NAME/inferred_geo_2.json \
# 	--config /mnt/infonas/data/awasthi/tmp/tmp_config.json

# python scripts/evaluation_google.py \
# 	--predictions_filepath logdir/$logdir_NAME/inferred_geo_2.json \
# 	--output_filepath logdir/$logdir_NAME/output_geo_2.json \
#   	--cache_filepath data/database/geo_test/geo_cache.json  \
#   	--timeout 18000

# logdir_NAME=duorat-finetune-bert-large-only_spider
# python scripts/infer_questions.py \
# 	--logdir logdir/$logdir_NAME \
# 	--data-config data/val_geo_oneshot.libsonnet \
# 	--questions data/database/geo_test/1shot_val_examples.json \
# 	--output-google logdir/$logdir_NAME/inferred_oneshot.json \
# 	--config /mnt/infonas/data/awasthi/tmp/tmp_config.json

# python scripts/evaluation_google.py \
# 	--predictions_filepath logdir/$logdir_NAME/inferred_oneshot.json \
# 	--output_filepath logdir/$logdir_NAME/output_oneshot.json \
#   	--cache_filepath data/database/geo_test/geo_cache.json  \
#   	--timeout 18000

###########
# logdir_NAME=duorat-finetune-spider-bert-large-on-geo-oneshot
# python scripts/infer_questions.py \
# 	--logdir logdir/$logdir_NAME \
# 	--data-config data/val_geo_oneshot.libsonnet \
# 	--questions data/database/geo_test/1shot_val_examples.json \
# 	--output-google logdir/$logdir_NAME/inferred.json

# python scripts/evaluation_google.py \
# 	--predictions_filepath logdir/$logdir_NAME/inferred.json \
# 	--output_filepath logdir/$logdir_NAME/output.json \
#   	--cache_filepath data/database/geo_test/geo_cache.json  \
#   	--timeout 18000
######


# python scripts/evaluation_google.py \
# 	--predictions_filepath /mnt/infonas/data/awasthi/semantic_parsing/smbop/dataset/geo_test/smbop_full_geo_inferred.json \
# 	--output_filepath /mnt/infonas/data/awasthi/semantic_parsing/smbop/dataset/geo_test/smbop_full_geo_output.json \
#   	--cache_filepath data/database/geo_test/geo_cache.json  \
#   	--timeout 18000 \
#   	--update_cache True

python scripts/evaluation_google.py \
	--predictions_filepath /mnt/a99/d0/awasthi/repos/Text2SQL/duoleo/logdir/duorat-finetune-bert-large-only_spider/inferred_oneshot.json \
	--output_filepath /mnt/a99/d0/awasthi/repos/Text2SQL/duoleo/logdir/duorat-finetune-bert-large-only_spider/output_oneshot_new.json \
  	--cache_filepath data/database/geo_test/geo_cache.json  \
  	--timeout 18000 \
  	--update_cache True


#python scripts/filter_results.py logdir/$logdir_NAME/output_geo.json