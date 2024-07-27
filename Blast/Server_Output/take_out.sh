#!/bin/bash

# Define input file and output files
input_file="trimmed_blast2go_no_third_col.tsv"
core_file="core.tsv"
cloud_file="cloud.tsv"

# Initialize the output files
> "$core_file"
> "$cloud_file"

# Read the input file line by line
{
    # Skip the header
    read -r header
    
    # Process the rest of the file
    while IFS=$'\t' read -r col1 col2 col3; do
        # Debugging: Print each line being processed
        echo "Processing line: $col1, $col2, $col3"
        
        if [ "$col2" == "39" ]; then
            echo -e "$col1" >> "$core_file"
            echo "Added $col1 to core.tsv"
        elif [ "$col2" == "1" ]; then
            echo -e "$col1" >> "$cloud_file"
            echo "Added $col1 to cloud.tsv"
        fi
    done
} < "$input_file"

echo "Values processed and written to $core_file and $cloud_file."
