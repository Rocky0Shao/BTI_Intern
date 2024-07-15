import subprocess
import pandas as pd
import argparse
import os
from concurrent.futures import ThreadPoolExecutor, as_completed

# Function to parse command-line arguments
def parse_args():
    parser = argparse.ArgumentParser(description='Run choose_one.py with varying parameters.')
    parser.add_argument('-t', '--num_threads', type=int, required=True, help='Number of threads to use')
    parser.add_argument('-r', '--num_repeats', type=int, default=10, help='Number of repetitions for each choose_one.py run')
    return parser.parse_args()

# Function to run the choose_one.py script with specified parameters
def run_choose_one(num_columns, run_num, num_repeats):
    output_file = f'Core_Pan_{num_columns}_{run_num}.tsv'
    result = subprocess.run(['python3', 'choose_one.py', '-n', str(num_columns), '-r', str(run_num)], capture_output=True)
    if result.returncode != 0:
        print(f"Error running choose_one.py with -n {num_columns} and run_num {run_num}")
        print(result.stderr.decode())
    else:
        print(f"Successfully ran choose_one.py with -n {num_columns} and run_num {run_num}")
    return output_file

# Function to execute the script and aggregate results
def execute_and_aggregate(num_threads, num_repeats):
    tasks = [(num_columns, run_num) for num_columns in range(1, 40) for run_num in range(1, 11)]
    results = []

    with ThreadPoolExecutor(max_workers=num_threads) as executor:
        futures = {executor.submit(run_choose_one, num_columns, run_num, num_repeats): (num_columns, run_num) for num_columns, run_num in tasks}

        for future in as_completed(futures):
            task = futures[future]
            try:
                output_file = future.result()
                results.append(output_file)
            except Exception as e:
                num_columns, run_num = task
                print(f"Exception occurred while processing num_columns={num_columns}, run_num={run_num}: {e}")
    print(results)
    # Collect all output data
    all_data = []
    for output_file in results:
        if os.path.exists(output_file):
            try:
                df = pd.read_csv(output_file, sep='\t')
                all_data.append(df)
            except Exception as e:
                print(f"Error reading {output_file}: {e}")
            finally:
                os.remove(output_file)  # Remove the individual file after reading its data

    # Concatenate all the results into a single DataFrame
    if all_data:
        try:
            final_df = pd.concat(all_data, ignore_index=True)
            # Save the final DataFrame to a new TSV file
            final_output_file_path = 'Aggregated_Results.tsv'
            final_df.to_csv(final_output_file_path, sep='\t', index=False)
            print(f"All results have been aggregated and saved to {final_output_file_path}")
        except Exception as e:
            print(f"Error concatenating data: {e}")
    else:
        print("No data to concatenate.")

# Main function
def main():
    args = parse_args()
    num_threads = args.num_threads
    num_repeats = args.num_repeats

    execute_and_aggregate(num_threads, num_repeats)

if __name__ == '__main__':
    main()


