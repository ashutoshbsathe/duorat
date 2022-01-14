function(prefix) {
  local databases = [
    'geo_test',
  ],

  name: 'spider',
  paths: [
    prefix + 'database/%s/1shot_val_examples.json' % [db]
    for db in databases
  ],
  tables_paths: [
    prefix + 'database/%s/tables.json' % [db]
    for db in databases
  ],
  db_path: prefix + 'database',
}