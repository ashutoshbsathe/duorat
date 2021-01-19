import sys
import json
from nltk.tokenize import TreebankWordTokenizer

input_file = sys.argv[1]
output_file = sys.argv[2]

with open(input_file) as f:
    data = json.load(f)


def ismixed(text: str) -> bool:
    return not text.isupper() and not text.islower()


for item in data["per_item"]:
    gold_sql = item["gold"]
    predicted_sql = TreebankWordTokenizer().tokenize(item["predicted"])
    predicted_parse_error = item["predicted_parse_error"]
    exact = item["exact"]
    db_name = item["db_name"]
    hardness = item["hardness"]
    question = item["question"]

    print(exact)
    print(predicted_parse_error)

    prev_sql_token = ''
    predicted_sql_tokens = predicted_sql.split()
    template_sql_list = []
    sql_comp_list = ['<', '<=', '>', '>=', '=', 'LIKE']
    for sql_token in predicted_sql_tokens:
        if '.' in sql_token:
            dot_pos = sql_token.find('.')
            bracket_pos = sql_token.find('(') + 1
            if bracket_pos == -1:
                bracket_pos = 0
            sql_token = sql_token.replace(sql_token[bracket_pos: dot_pos], '@table')
            dot_pos = sql_token.find('.')
            if sql_token.find(',') == -1:
                sql_token = sql_token.replace(sql_token[dot_pos + 1:], '@col')
            else:
                sql_token = sql_token.replace(sql_token[dot_pos + 1: sql_token.find(',')], '@col')
        elif prev_sql_token == 'FROM' or prev_sql_token == 'JOIN':
            sql_token = "@table"
        elif not sql_token.isupper() and not ismixed(sql_token) and sql_token not in sql_comp_list:
            if prev_sql_token in sql_comp_list:
                sql_token = "@value"

        prev_sql_token = sql_token
        template_sql_list.append(sql_token)

    template_sql = ' '.join(template_sql_list)
    print(predicted_sql)
    print(template_sql)
