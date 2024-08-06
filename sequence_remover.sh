#!/bin/bash
mkdir -p filtered_samples
for sample in *.fastq.gz; do
    # Extract the base name of the file
    base_name=$(basename "$sample" .fastq.gz)
    sequence_count=$(zcat "$sample" | grep -c '^@')      if [ "$sequence_count" -ge 100 ]; then   #here trheshold is 100 sequences in one sample
        cp "$sample" filtered_samples/
        echo "$base_name,$sequence_count"
    fi
done > sequences.csv
