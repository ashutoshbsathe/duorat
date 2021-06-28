(import 'duorat-finetune-bert-large.jsonnet') {
    local PREFIX = 'data/',
    data: {
        name: 'Spider_dev55',
        train: (import '../../data/dev55.libsonnet')(prefix=PREFIX),
        val: (import '../../data/val_dev55.libsonnet')(prefix=PREFIX),
        type: 'original'
    },

    model+: {
        encoder+: {
            initial_encoder+: {
                pretrained_model_name_or_path: 'google/electra-base-discriminator',
            },
            source_relation_types: {
                use_schema_linking: true,
                high_confidence_db_content_schema_linking: true,
                low_confidence_db_content_schema_linking: true,
            }
        },
        preproc+: {
            schema_linker+: {
                whole_entry_db_content_confidence: 'high',
                partial_entry_db_content_confidence: 'low'
            },
            tokenizer+: {
                pretrained_model_name_or_path: 'google/electra-base-discriminator',
            },
            transition_system+: {
                tokenizer+: {
                    pretrained_model_name_or_path: 'google/electra-base-discriminator',
                }
            },
            keep_vocab: true,
        }
    },

    lr_scheduler+: {
        decay_steps: 8000,
    },

    train+: {
        batch_size: 8,
        n_grad_accumulation_steps: 6,
        max_steps: 10000,
        initialize_from: {
            pretrained_model_path: './logdir/duorat-spider-new-db-content-with-pretrained-embeddings-electra-base-150k-steps',
        },
    }
}
