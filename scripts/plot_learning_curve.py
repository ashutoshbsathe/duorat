# @Vu Hoang & Thanh Vu @ Oracle

from matplotlib import pyplot as plt
from scipy.optimize import curve_fit
import pandas as pd
import os


def plot(x, y, xlabel, output_file, use_logscale=True):
    """
    Plotting the line chart
    """
    plt.plot(x, y, '-o')
    if use_logscale:
        plt.xlabel(xlabel + " - LogScale")
        plt.ylabel("Eval 1-ExactMatchSetAccuracy - LogScale")
        plt.yscale("log")
        plt.xscale("log")
    else:
        plt.xlabel(xlabel)
        plt.ylabel("Eval 1-ExactMatchSetAccuracy")
    plt.tight_layout()
    plt.savefig(f"{output_file}")
    plt.close()


def func(x, a, b, c):
    """
    Function for the curve_fit
    """
    return a + b * (x ** c)


def func_zero_a(x, b, c):
    """
    Function for the curve_fit when a is set to 0
    """
    return b * (x ** c)


def get_x_from_y(e, a, b, c):
    """
    Get total number of examples needed to get the error e
    """
    if e - a <= 0:
        return - 1
    n = ((e - a) / b) ** (1 / c)
    return n


def get_sigma(xdata, ydata):
    # sigma = 1 / (n / (e * (1 - e) ) )
    # where n is the number of training examples for that data point and e is the (gold) error rate for that data item.
    output = []
    for i in range(len(xdata)):
        output.append(1 / (xdata[i] / (ydata[i] * (1 - ydata[i]))))
    return output


def normalise(xdata, ydata, threshold):
    """
    To remove data points with y value is larger than the threshold
    """
    output = []
    for i in range(len(ydata)):
        if ydata[i] <= threshold:
            output.append(xdata[i])
    return output


def run_regression(xdata, ydata, output_file, xlabel, use_logscale=True, set_a_to_zero=True):
    sigma = get_sigma(xdata, ydata)
    a = 0
    if set_a_to_zero:
        popt, pcov = curve_fit(func_zero_a, xdata, ydata, sigma=sigma)
        plt.plot(xdata, ydata, 'o--', label='Few-shot learning performance')
        plt.plot(xdata, func_zero_a(xdata, *popt), 'g-',
                 label='Least-squares fit: b=%5.3f, c=%5.3f' % tuple(popt))
        b, c = tuple(popt)
    else:
        popt, pcov = curve_fit(func, xdata, ydata, sigma=sigma, method="trf", bounds=(-1, 1), maxfev=2000)
        plt.plot(xdata, ydata, 'o--', label='Few-shot learning performance')
        plt.plot(xdata, func(xdata, *popt), 'g-',
                 label='Least-squares fit: a=%5.3f, b=%5.3f, c=%5.3f' % tuple(popt))
        a, b, c = tuple(popt)
    if use_logscale:
        plt.xlabel(f"{xlabel} - LogScale")
        plt.ylabel('Eval 1-ExactMatchSetAccuracy - LogScale')
        plt.xscale('log')
        plt.yscale('log')
    else:
        plt.xlabel(f"{xlabel}")
        plt.ylabel('Eval 1-ExactMatchSetAccuracy')
        plt.ylim(0, 1)
    plt.legend()
    plt.tight_layout()
    plt.savefig(f"{output_file}")
    plt.close()
    return a, b, c


def process_csv_file(file_path, e_prime=0.1, threshold=1.0, set_a_to_zero=True):
    """
    Process a file
    """
    dataset = file_path.split("/")[-1].split(".")[0]
    with open(file_path) as reader:
        df = pd.read_csv(reader)
        _1minusacc = df["1-ExactMatchSetAccuracy"]
        fraction = df["Fraction"]
        num_examples = df["#Examples"]

        # Plot the logscale line charts
        plot(fraction, _1minusacc, "Training Fraction", f"{os.path.dirname(file_path)}/fraction.{dataset}.png")
        plot(num_examples, _1minusacc, "Training Examples (Total)", f"{os.path.dirname(file_path)}/examples.{dataset}.png")

        # Get the performance on the full data (which is the last line in the input file)
        full_data_1minusf1 = _1minusacc[len(_1minusacc) - 1]
        full_data_num_examples = num_examples[len(_1minusacc) - 1]

        # Get the remaining data for curve_fit
        num_examples = list(num_examples[: len(num_examples) - 1])
        _1minusacc = list(_1minusacc[: len(_1minusacc) - 1])

        # Normalise data based on the threshold
        num_examples = normalise(num_examples, _1minusacc, threshold)
        _1minusacc = normalise(_1minusacc, _1minusacc, threshold)

        a, b, c = run_regression(num_examples, _1minusacc,
                                 f"{os.path.dirname(file_path)}/curve_fit.total.examples.{dataset}.0.{threshold}.{set_a_to_zero}.png",
                                 "Training Examples (Total)", False, set_a_to_zero)

        pred_e = func(full_data_num_examples, a, b, c)
        print("\n~~~~Training Examples (Total)~~~~")
        print(f"RSM of the relative residuals: {round(abs(pred_e / full_data_1minusf1 - 1), 4)}")
        print(f"Number examples needed to get e'={e_prime}: {int(get_x_from_y(e_prime, a, b, c))}")

        run_regression(num_examples, _1minusacc,
                       f"{os.path.dirname(file_path)}/curve_fit.total.examples.logscale.{dataset}.0.{threshold}.{set_a_to_zero}.png",
                       "Training Examples (Total)", True, set_a_to_zero)


if __name__ == '__main__':
    datasets = ["Spider@0.2", "Sparc@0.3", "CoSQL@0.4"]
    folder_path = "./logdir/learning_curve"
    for dataset in datasets:
        dataset_path = f"{folder_path}/{dataset.split('@')[0]}.csv"
        dataset_eprime = float(dataset.split('@')[1])
        if not os.path.exists(dataset_path):
            continue

        print("~~~~~~~~~~~~~" * 2)
        print(dataset)
        print("\nProcessing: a + bn^c")
        process_csv_file(dataset_path, e_prime=dataset_eprime, threshold=1.0, set_a_to_zero=False)

        print("\nProcessing: bn^c ~ a = 0")
        process_csv_file(dataset_path, e_prime=dataset_eprime, threshold=1.0)

        print(f"\nProcessing: bn^c ~ a = 0 + threshold = {0.5 if 'CoSQL' not in dataset else 0.6}")
        process_csv_file(dataset_path, e_prime=dataset_eprime, threshold=0.5 if 'CoSQL' not in dataset else 0.6)
