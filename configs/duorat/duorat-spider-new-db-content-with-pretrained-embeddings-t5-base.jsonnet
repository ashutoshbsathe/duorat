(import 'duorat-finetune-bert-large.jsonnet') {
    model+: {
        encoder+: {
            initial_encoder+: {
                pretrained_model_name_or_path: 't5-base',
                use_outputs_from: 'enc',
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
                pretrained_model_name_or_path: 't5-base',
            },
            transition_system+: {
                tokenizer+: {
                    pretrained_model_name_or_path: 't5-base',
                }
            }
        }
    },

    train+: {
        "batch_size": 8,
        "n_grad_accumulation_steps": 6,
    }
}
