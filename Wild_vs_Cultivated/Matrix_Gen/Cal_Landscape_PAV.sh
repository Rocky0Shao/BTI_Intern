#!/bin/bash

# Input and output file names
input_file="/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Matrix_Gen/lancscape.tsv"
output_file="/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Matrix_Gen/output.txt"

# Initialize the output file
> "$output_file"

# Skip the header line
header_skipped=false

# Read the file line by line
while IFS=$'\t' read -r -a line; do
    if [ "$header_skipped" = false ]; then
        header_skipped=true
        continue
    fi

    # First element of the line
    first_element="${line[0]}"

    # Count the number of 1s in the row
    count_ones=0
    for element in "${line[@]:1}"; do
        if [ "$element" -eq 1 ]; then
            ((count_ones++))
        fi
    done

    # Calculate the ratio (num of 1s) / (Total_col_num - 1)
    total_cols=${#line[@]}
    ratio=$(awk "BEGIN {print $count_ones / ($total_cols - 1)}")

    # Write to the output file
    echo -e "$first_element\t$count_ones\t$ratio" >> "$output_file"
done < "$input_file"
