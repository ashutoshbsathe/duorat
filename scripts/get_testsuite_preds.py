import sys
import json

duorat_output_file = sys.argv[1]
original_sparc_data_file = sys.argv[2]
testsuite_output_file = sys.argv[3]

fout_testsuite = open(testsuite_output_file, 'w')

with open(original_sparc_data_file, "r") as f:
    original_data = json.load(f)

predictions = []
with open(duorat_output_file, "r") as f:
    for line in f:
        line = line.strip()
        entry_data = json.loads(line)
        predictions.append(entry_data["beams"][0]["inferred_code"])

i = 0
for example in original_data:
    interaction = example["interaction"]

    for pred in predictions[i:i+len(interaction)]:
        fout_testsuite.write(f"{pred}\n")
        i += 1
    fout_testsuite.write("\n")

fout_testsuite.flush()
fout_testsuite.close()
