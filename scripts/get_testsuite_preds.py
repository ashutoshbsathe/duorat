import sys
import json
import re

duorat_output_file = sys.argv[1]
original_data_file = sys.argv[2]
testsuite_output_file = sys.argv[3]
gold_fixed_file = sys.argv[4]

ignore_patterns = None
if len(sys.argv) > 5:
    ignore_patterns = sys.argv[5]
print(ignore_patterns)

fout_testsuite = open(testsuite_output_file, 'w')
fout_gold_fixed = open(gold_fixed_file, "w")

with open(original_data_file, "r") as f:
    original_data = json.load(f)

predictions = []
count_empty_preds = 0
count_preds = 0
with open(duorat_output_file, "r") as f:
    prev_inferred_code = ""
    for line in f:
        line = line.strip()
        entry_data = json.loads(line)
        if len(entry_data["beams"]) > 0:
            predictions.append(entry_data["beams"][0]["inferred_code"])
            prev_inferred_code = predictions[-1]
        else:
            predictions.append(prev_inferred_code)
            count_empty_preds += 1
        count_preds += 1
print(f"There are {count_empty_preds} out of {count_preds} predictions with empty output(s).")

i = 0
for example in original_data:
    interaction = example["interaction"]

    new_interaction = []
    for utter_info in interaction:
        if ignore_patterns and re.search(ignore_patterns, utter_info["utterance"]):
            print(f"ignored: {utter_info}")
            continue
        new_interaction.append(utter_info)

    for utter_info in new_interaction:
        new_query = utter_info['query'].replace('\n', '')
        fout_gold_fixed.write(f"{new_query}\t{example['database_id']}\n")
    fout_gold_fixed.write("\n")

    for pred in predictions[i:i+len(new_interaction)]:
        fout_testsuite.write(f"{pred}\n")
        i += 1
    fout_testsuite.write("\n")

print(f"No. of actual predictions: {i}")

fout_testsuite.flush()
fout_testsuite.close()
fout_gold_fixed.flush()
fout_gold_fixed.close()
