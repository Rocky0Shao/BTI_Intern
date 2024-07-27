#!/bin/bash

# Define input and output files
input_file="blast2go.annot"
output_file="trimmed_blast2go.tsv"

# Initialize the output file
> "$output_file"

# Read the input file line by line
while IFS=$'\t' read -r col1 col2 col3; do
    # Check if there are exactly three columns
    if [ -n "$col3" ]; then
        echo -e "$col1\t$col2\t$col3" >> "$output_file"
    fi
done < "$input_file"

echo "Filtered rows with exactly three columns have been written to $output_file."

