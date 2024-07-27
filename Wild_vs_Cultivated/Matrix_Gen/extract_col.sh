#!/bin/bash

# Usage: ./extract_columns.sh input_file output_file column_numbers
# Example: ./extract_columns.sh input.tsv output.tsv 1,3,5

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file output_file column_numbers"
    echo "Example: $0 input.tsv output.tsv 1,3,5"
    exit 1
fi

# Assign arguments to variables
input_file=$1
output_file=$2
columns=$3

# Extract specified columns and save to output file
awk -v cols="$columns" '
BEGIN {
    split(cols, arr, ",");
}
{
    for (i in arr) {
        printf "%s\t", $arr[i];
    }
    printf "\n";
}
' $input_file > $output_file

echo "Specified columns extracted and saved to $output_file."
#./extract_columns.sh input.tsv output.tsv 1,3,5
