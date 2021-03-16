# get_tables_wikisql.py
# Vu Hoang
# @Oracle

import json
import os
import sys
import sqlite3

from duorat.preproc.utils import refine_schema_names


def dump_wikisql_db_json_schema(db, db_name, db_id):
    """read table and column info"""

    conn = sqlite3.connect(db)
    conn.execute("pragma foreign_keys=ON")
    cursor = conn.execute("SELECT name FROM sqlite_master WHERE type='table';")

    all_tables = []

    fk_holder = []
    for i, item in enumerate(cursor.fetchall()):
        table_name = item[0]

        table_info = {
            "db_id": f"{db_name}-{db_id}_{table_name}",
            "table_names_original": [],
            "table_names": [],
            "column_names_original": [(-1, "*")],
            "column_names": [(-1, "*")],
            "column_types": ["text"],
            "primary_keys": [],
            "foreign_keys": [],
        }

        table_info["table_names_original"].append(table_name)
        table_info["table_names"].append(table_name.lower().replace("_", " "))
        fks = conn.execute(
            "PRAGMA foreign_key_list('{}') ".format(table_name)
        ).fetchall()
        # print("db:{} table:{} fks:{}".format(f,table_name,fks))
        fk_holder.extend([[(table_name, fk[3]), (fk[2], fk[4])] for fk in fks])
        cur = conn.execute("PRAGMA table_info('{}') ".format(table_name))
        for j, col in enumerate(cur.fetchall()):
            table_info["column_names_original"].append((j, col[1]))
            table_info["column_names"].append((j, col[1].lower().replace("_", " ")))
            # varchar, '' -> text, int, numeric -> integer,
            col_type = col[2].lower()
            if (
                    "char" in col_type
                    or col_type == ""
                    or "text" in col_type
                    or "var" in col_type
            ):
                table_info["column_types"].append("text")
            elif (
                    "int" in col_type
                    or "numeric" in col_type
                    or "decimal" in col_type
                    or "number" in col_type
                    or "id" in col_type
                    or "real" in col_type
                    or "double" in col_type
                    or "float" in col_type
            ):
                table_info["column_types"].append("number")
            elif "date" in col_type or "time" in col_type or "year" in col_type:
                table_info["column_types"].append("time")
            elif "boolean" in col_type:
                table_info["column_types"].append("boolean")
            else:
                table_info["column_types"].append("others")

            if col[5] == 1:
                table_info["primary_keys"].append(len(table_info["column_names"]) - 1)

        all_tables.append(table_info)

    return all_tables


if __name__ == "__main__":
    """
    Extract tables.json for a single sqlite DB
    """
    if len(sys.argv) < 2:
        print(
            "Usage: python get_tables_wikisql.py [sqlite file] [output file name e.g. output.json]"
        )
        sys.exit()
    sqlite_file = sys.argv[1]
    output_file = sys.argv[2]

    assert sqlite_file.endswith('.db')
    db_id = os.path.basename(sqlite_file)[:-3]

    schemas = dump_wikisql_db_json_schema(sqlite_file, 'wikisql', db_id)
    schemas = [refine_schema_names(schema) for schema in schemas]

    with open(output_file, "wt") as out:
        json.dump(schemas, out, sort_keys=True, indent=2, separators=(",", ": "))
