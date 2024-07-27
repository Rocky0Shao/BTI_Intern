#!/bin/bash

# Define input file and temporary file
input_file="trimmed_blast2go_no_third_col.tsv"
temp_file="temp_blast2go.tsv"

# Check if the input file exists and is not empty
if [[ ! -s "$input_file" ]]; then
    echo "Error: Input file '$input_file' does not exist or is empty."
    exit 1
fi

# Initialize the temporary file
> "$temp_file"

# Read the input file line by line
while IFS=$'\t' read -r col1 col2 col3; do
    # If col1 is empty, skip the line
    if [[ -z "$col1" ]]; then
        continue
    fi

    # Write the second column first and then the first column to the temporary file, ignoring the third column
    echo -e "$col2\t$col1" >> "$temp_file"
done < "$input_file"

# Replace the original file with the modified content
mv "$temp_file" "$input_file"

echo "Third column removed and first two columns swapped in $input_file."

