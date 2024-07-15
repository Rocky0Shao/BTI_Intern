import pandas as pd
import numpy as np
import argparse

# Function to parse command-line arguments
def parse_args():
    parser = argparse.ArgumentParser(description='Randomly select columns and analyze them.')
    parser.add_argument('-n', '--num_columns', type=int, required=True, help='Number of columns to randomly select')
    return parser.parse_args()

# Load the TSV file
file_path = 'I_1.5.tsv'
df = pd.read_csv(file_path, sep='\t', index_col=0)

# Function to randomly select columns and perform the analysis
def analyze_columns(df, num_columns):
    # Randomly select columns
    selected_columns = np.random.choice(df.columns, size=num_columns, replace=False)
    
    # Initialize counters
    all_1_count = 0
    at_least_1_count = 0
    
    # Iterate through rows
    for idx, row in df[selected_columns].iterrows():
        if (row == 1).all():
            all_1_count += 1
        if (row == 1).any():
            at_least_1_count += 1
    
    return all_1_count, at_least_1_count

# Main function
def main():
    args = parse_args()
    num_columns = args.num_columns
    
    # Analyze the selected columns
    all_1_count, at_least_1_count = analyze_columns(df, num_columns)

    # Create the output DataFrame
    output_df = pd.DataFrame({
        'num_gene_chose': [num_columns],
        'All_1': [all_1_count],
        'At_Least_1': [at_least_1_count]
    })

    # Save the output to a TSV file
    output_file_path = 'Core_Pan.tsv'
    output_df.to_csv(output_file_path, sep='\t', index=False)

if __name__ == '__main__':
    main()
