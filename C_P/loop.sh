#!/bin/bash

# Name of the output file
OUTPUT_FILE="output.tsv"

# Create an empty output file with the specified headers
echo -e "Gen_Num\trep\tAll_1\tAt_Least_1" > $OUTPUT_FILE

# Loop from 2 to 39 inclusive
for n in {1..39}
do
    # Run the choose_one.py command with the current value of n
    python3 choose_one.py -n $n -r 10
    
    # Append the content of Core_Pan.tsv to the output file excluding the first row
    tail -n +2 Core_Pan.tsv >> $OUTPUT_FILE
done

