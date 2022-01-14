(import 'duorat-base.libsonnet')(output_from=true) {
    local PREFIX = 'data/',

    data: {
        train: (import '../../data/train_geo_oneshot.libsonnet')(prefix=PREFIX),
        val: (import '../../data/val_geo_oneshot.libsonnet')(prefix=PREFIX),
    },
    lr_scheduler: {
        "decay_steps": 19500,
        "end_lr": 0,
        "name": "bert_warmup_polynomial",
        "num_warmup_steps": 500,
        "power": 1,
        "start_lr": 0.00005,
        "bert_factor": 8
    },
    model+: {
        name: 'LMDuoRAT',
        encoder: {
            initial_encoder: {
                name: 'Bert',
                pretrained_model_name_or_path: 'bert-large-uncased-whole-word-masking',
                trainable: true,
                num_return_layers: 1,
                embed_dim: 256,
                use_dedicated_gpu: false,
                use_affine_transformation: false,
                use_attention_mask: false,
                use_token_type_ids: false,
                use_position_ids: false,
                use_segments: false,
                use_outputs_from: 'enc',
            },
            "rat_attention_dropout": 0.1,
            "rat_dropout": 0.1,
            "rat_ffn_dim": 1024,
            "rat_num_heads": 8,
            "rat_num_layers": 8,
            "rat_relu_dropout": 0.1,
            source_relation_types: {
                use_schema_linking: true,
            },
            schema_input_token_ordering: '[column][table]',
            schema_source_token_ordering: '[column][table]',
            max_source_length: 200,
        },
        decoder: {
            "action_embed_dim": 64,
            "field_embed_dim": 64,
            "type_embed_dim": 64,
            "p_mask": 0.2,
            "rat_attention_dropout": 0.1,
            "rat_dropout": 0.1,
            "rat_ffn_dim": 256,
            "rat_num_heads": 8,
            "rat_num_layers": 2,
            "rat_relu_dropout": 0.1,
            pointer: {
                name: 'BahdanauMemEfficient',
                proj_size: 50,
            },
        },
        preproc+: {
            name: 'BertDuoRAT',
            add_cls_token: true,
            add_sep_token: false,

            min_freq: 5,
            max_count: 5000,

            tokenizer: {
                name: 'BERTTokenizer',
                pretrained_model_name_or_path: 'bert-large-uncased-whole-word-masking',
            },
            transition_system+: {
                tokenizer: {
                    name: 'BERTTokenizer',
                    pretrained_model_name_or_path: 'bert-large-uncased-whole-word-masking',
                }
            }
        },
    },
    "train": {
        "amp_enabled": true,
        "batch_size": 4,  #9,
        "n_grad_accumulation_steps": 2,  #3,
        "eval_batch_size": 32,
        "eval_beam_size": 1,
        "eval_decode_max_time_step": 500,
        "eval_every_n": 100,
        "eval_nproc": 1,
        "eval_on_train": false,
        "eval_on_val": true,
        "infer_min_n": 100,
        "max_steps": 20000,
        "num_eval_items": 552,
        "report_every_n": 10,
        "initialize_from": '/home/ashutosh/HDD/IITB/Sem_1/MS_RnD/duyvuleo-duorat-vuh-dev/logdir/duorat-finetune-bert-large-only_spider/',
    }
}
