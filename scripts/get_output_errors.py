import sys
import json

input_file = sys.argv[1]
output_file = sys.argv[2]

incorrect_entries = []
with open(input_file) as inpf:
    data = json.load(inpf)
    entries = data["per_item"]
    for entry in entries:
        db_name = entry["db_name"]
        db_path = entry["db_path"]
        question = entry["question"]
        gold_sql = entry["gold"]
        predicted_sql = entry["predicted"]
        exact = bool(entry["exact"])
        if not exact:
            incorrect_entries.append({"db_name": db_name,
                                      "db_path": db_path,
                                      "question": question,
                                      "predict_sql": predicted_sql,
                                      "gold_sql": gold_sql})

with open(output_file) as outf:
    json.dump(incorrect_entries, outf, indent=2)
