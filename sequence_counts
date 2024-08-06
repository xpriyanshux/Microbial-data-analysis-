#!/bin/bash
for sample in *.fastq.gz; do
    base_name=$(basename "$sample" .fastq.gz)
    sequence_count=$(zcat "$sample" | grep -c '^@')
    echo "$base_name,$sequence_count"
done > sequences.csv
# a csv file named sequences.csv will be saved in the output directory
