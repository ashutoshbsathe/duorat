import argparse
import json
import _jsonnet
import tqdm

# noinspection PyUnresolvedReferences
from duorat import datasets

# noinspection PyUnresolvedReferences
from duorat.preproc import offline, utils

# noinspection PyUnresolvedReferences
from duorat.utils import schema_linker

# noinspection PyUnresolvedReferences
from duorat.asdl.lang import spider

from duorat.utils import registry


class Preprocessor:
    def __init__(self, config):
        self.config = config
        self.model_preproc = registry.construct(
            "preproc", self.config["model"]["preproc"],
        )

    def preprocess(self, sections, keep_vocab):
        self.model_preproc.clear_items()

        if isinstance(self.config["data"], dict):
            datasets = [self.config["data"]]
        elif isinstance(self.config["data"], list):
            datasets = self.config["data"]
        else:
            raise ValueError(f"Error in config.data, either a list or dictionary.")

        for dataset in datasets:
            if 'name' in dataset:
                print(f"Processing dataset {dataset['name']}...")
            for section in sections:
                data = registry.construct("dataset",
                                          dataset[section])  # SpiderDataset/SparcDataset/CoSQLDataset
                sample_size = self.config["data"].get(f'{section}_sample_size', None)
                if section in 'train_sample_ratio' and 'train_sample_ratio' in self.config["data"]:
                    sample_size = int(len(data) * float(self.config["data"]['train_sample_ratio'] / 100))
                data.sample(sample_size=sample_size)
                for i, item in enumerate(tqdm.tqdm(data, desc=section, dynamic_ncols=True)):  # SpiderItem/SparcItem
                    to_add, validation_info = self.model_preproc.validate_item(
                        item, section
                    )
                    if to_add:
                        self.model_preproc.add_item(item, section, validation_info)
        if keep_vocab:
            self.model_preproc.save_examples()
        else:
            self.model_preproc.save()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", required=True)
    parser.add_argument("--config-args")
    parser.add_argument("--sections", nargs='+', default=None,
                        help="Preprocess only the listed sections")
    parser.add_argument("--keep-vocab", action='store_true',
                        help="Keep existing vocabulary files")
    args = parser.parse_args()

    if args.config_args:
        config = json.loads(
            _jsonnet.evaluate_file(args.config, tla_codes={"args": args.config_args})
        )
    else:
        config = json.loads(_jsonnet.evaluate_file(args.config))

    sections = args.sections if args.sections is not None else config["data"].keys()

    preprocessor = Preprocessor(config)
    preprocessor.preprocess(sections, args.keep_vocab)


if __name__ == "__main__":
    main()
