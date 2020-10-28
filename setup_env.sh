#!/bin/bash

export CACHE_DIR=./logdir
export TRANSFORMERS_CACHE=./logdir
export CORENLP_HOME=./third_party/corenlp/stanford-corenlp-full-2018-10-05

exec "$@"
