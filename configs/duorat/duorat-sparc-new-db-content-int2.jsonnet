(import 'duorat-finetune-bert-large.jsonnet') {
    local PREFIX = './data/sparc',

    data: {
        train: (import '../../data/train_sparc.libsonnet')(prefix=PREFIX),
        val: (import '../../data/val_sparc.libsonnet')(prefix=PREFIX),
    },

    model+: {
        encoder+: {
            source_relation_types: {
                use_schema_linking: true,
                high_confidence_db_content_schema_linking: true,
                low_confidence_db_content_schema_linking: true,
            },
            interaction_size: 2,
            max_source_length: 256,
        },
        preproc+: {
            schema_linker+: {
                whole_entry_db_content_confidence: 'high',
                partial_entry_db_content_confidence: 'low'
            }
        }
    },
}
