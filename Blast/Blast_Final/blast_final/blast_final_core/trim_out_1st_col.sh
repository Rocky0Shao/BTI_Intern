#!/bin/bash

# Define input and output files
input_file="trimmed_blast2go_2_3_row.tsv"
output_file="trimmed_blast2go_no_first_col.tsv"

# Initialize the output file
> "$output_file"

# Read the input file line by line
while IFS=$'\t' read -r col1 col2 col3; do
    # Write the second and third columns to the output file
    echo -e "$col2\t$col3" >> "$output_file"
done < "$input_file"

echo "First column removed and new file created as $output_file."

