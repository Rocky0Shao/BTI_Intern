import pandas as pd
import numpy as np
import argparse
import os

# Function to parse command-line arguments
def parse_args():
    parser = argparse.ArgumentParser(description='Randomly select columns and analyze them.')
    parser.add_argument('-n', '--num_columns', type=int, required=True, help='Number of columns to randomly select')
    parser.add_argument('-r', '--num_repeats', type=int, required=True, help='Number of times to repeat the analysis')
    return parser.parse_args()

# Load the TSV file once to avoid reading it multiple times
file_path = 'I_1.5.tsv'
#df = pd.read_csv(file_path, sep='\t', index_col=0)
df = pd.read_csv(file_path, sep = '\t')
#print(len(df.columns))
# Function to randomly select columns and perform the analysis
def analyze_columns(df, num_columns):
    # Adjusted to exclude the header column from the selection
    selected_columns = np.random.choice(df.columns[1:], size=num_columns, replace=False)
    all_1_count = (df[selected_columns] == 1).all(axis=1).sum()
    at_least_1_count = (df[selected_columns] == 1).any(axis=1).sum()
    return all_1_count, at_least_1_count

# Main function
def main():
    args = parse_args()
    num_columns = args.num_columns
    num_repeats = args.num_repeats

    output_data = []

    for rep in range(1, num_repeats + 1):
        all_1_count, at_least_1_count = analyze_columns(df, num_columns)
        output_data.append([num_columns, rep, all_1_count, at_least_1_count])

    output_df = pd.DataFrame(output_data, columns=['num_gene', 'rep', 'All_1', 'At_Least_1'])
    output_df.to_csv('Core_Pan.tsv', sep='\t', index=False)

if __name__ == '__main__':
    main()

