import sys
import json


def postprocess(sql: str) -> str:
    # " AirCon " -> "AirCon"
    sql = sql.replace("\"", " \" ")
    sql = sql.replace("  ", " ")
    # sql = sql.replace("\" ", "\"").replace(" \"", "\"")

    # 7 . 5 -> 7.5
    sql = sql.replace(" . ", ".")

    # =" -> = "
    # sql = sql.replace("=\"", "= \"")

    # LIKE" -> LIKE "
    # sql = sql.replace("LIKE\"", "LIKE \"")

    # "OR -> " OR
    # sql = sql.replace("\"OR", "\" OR")

    # "AND -> " AND
    # sql = sql.replace("\"AND", "\" AND")

    return sql


def is_sql_keyword(text: str) -> bool:
    s_text = text
    if s_text[0] == '(':
        s_text = s_text[1:]
    if s_text in SQL_KEYWORDS:
        return True
    return False


sql_kw_file = sys.argv[1]
input_file = sys.argv[2]
output_file = sys.argv[3]

# read SQL keywords
SQL_KEYWORDS = set()
with open(sql_kw_file) as f:
    for line in f:
        line = line.strip()
        for kw_token in line.split():
            SQL_KEYWORDS.add(kw_token)

# read data
with open(input_file) as f:
    data = json.load(f)

unique_template_set = set()
for item in data["per_item"]:
    gold_sql = item["gold"]
    predicted_sql = postprocess(item["predicted"])
    predicted_parse_error = item["predicted_parse_error"]
    exact = bool(item["exact"])
    db_name = item["db_name"]
    hardness = item["hardness"]
    question = item["question"]

    if exact and not predicted_parse_error:
        prev_sql_token = ''
        predicted_sql_tokens = predicted_sql.split()
        template_sql_list = []
        sql_comp_list = ['<', '<=', '>', '>=', '=', '!=', 'LIKE']
        for sql_token in predicted_sql_tokens:
            if '.' in sql_token:
                dot_pos = sql_token.find('.')
                open_bracket_pos = sql_token.find('(') + 1
                if open_bracket_pos == -1:
                    open_bracket_pos = 0
                sql_token = sql_token.replace(sql_token[open_bracket_pos: dot_pos], '@table')
                dot_pos = sql_token.find('.')
                if open_bracket_pos == 0:
                    if sql_token.find(')') == -1:
                        if sql_token.find(',') == -1:
                            sql_token = sql_token.replace(sql_token[dot_pos + 1:], '@col')
                        else:
                            sql_token = sql_token.replace(sql_token[dot_pos + 1: sql_token.find(',')], '@col')
                    else:
                        sql_token = sql_token.replace(sql_token[dot_pos + 1: sql_token.find(')')], '@col')
                else:
                    sql_token = sql_token.replace(sql_token[dot_pos + 1: sql_token.find(')')], '@col')
            elif prev_sql_token == 'FROM' or prev_sql_token == 'JOIN':
                if sql_token.find(")") == -1:
                    sql_token = "@table"
                else:
                    sql_token = "@table)"
            elif not is_sql_keyword(sql_token) and sql_token not in sql_comp_list:
                value_str = "@value"
                if sql_token[-1] == ')':
                    value_str = "@value)"
                if prev_sql_token in sql_comp_list:
                    sql_token = value_str
                elif prev_sql_token == '@value':
                    template_sql_list.pop()
                    sql_token = value_str

            prev_sql_token = sql_token
            template_sql_list.append(sql_token)

        template_sql = ' '.join(template_sql_list)
        print(predicted_sql)
        print(template_sql)

        unique_template_set.add(template_sql)

unique_template_list = list(unique_template_set)
print(f"There are {len(unique_template_list)} SQL templates.")
#print(unique_template_list)

with open(output_file, "w") as fout:
    for template in unique_template_list.sort(key=len, reverse=False):
        fout.write(f"{template}\n")
