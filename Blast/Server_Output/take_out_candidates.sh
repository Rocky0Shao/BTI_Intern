#!/bin/bash

# Define input and output files
core_file="core.tsv"
input_file="trimmed_blast2go.tsv"
temp_file="temp_trimmed_blast2go.tsv"

# Read core.tsv into an array
mapfile -t core_values < "$core_file"

# Initialize the temporary file
> "$temp_file"

# Read the input file line by line
while IFS=$'\t' read -r col1 col2 col3; do
    # Check if col1 is in core_values
    if printf '%s\n' "${core_values[@]}" | grep -q -P "^$col1$"; then
        # If col1 is in core_values, write the row to the temporary file
        echo -e "$col1\t$col2\t$col3" >> "$temp_file"
    fi
done < "$input_file"

# Replace the original file with the modified content
mv "$temp_file" "$input_file"

echo "Filtered rows have been written to $input_file."
