from duorat.datasets.cosql import CoSQLDataset
from duorat.datasets.spider import SpiderItem

from typing import List


class UnifiedDataset(CoSQLDataset):
    def __init__(self):
        super().__init__()

    def extend(self, examples: List[SpiderItem]):
        self.examples.extend(examples)
