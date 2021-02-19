from typing import List

from duorat.datasets.sparc import SparcDataset
from duorat.utils import registry


@registry.register("dataset", "cosql")
class CoSQLDataset(SparcDataset):
    def __init__(self, examples_files: List[str], tables_files: List[str], db_path: str):
        super().__init__(examples_files=examples_files, tables_files=tables_files, db_path=db_path)
