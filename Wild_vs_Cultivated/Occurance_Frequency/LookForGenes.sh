#!/bin/bash

# Extract the GO Term column from w_c_total_results.tsv (assuming it's the third column) and save it to geneNames
geneNames=$(cut -f3 w_c_total_results.tsv | tail -n +2)

# Create an associative array for faster lookup
declare -A geneNamesArray
while IFS= read -r line; do
  geneNamesArray["$line"]=1
done <<< "$geneNames"

# Output file
output_file="output.tsv"

# Read blast2go_7_26.tsv and process each row
while IFS=$'\t' read -r col1 col2 _; do
  if [[ ${geneNamesArray["$col2"]} ]]; then
    echo -e "$col1" >> "$output_file"
  fi
done < blast2go_7_26.tsv
