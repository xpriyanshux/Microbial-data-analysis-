#!/bin/bash
FASTQ_DIR="fastq files path"
OUTPUT_DIR="output of fastp path"
mkdir -p "$OUTPUT_DIR"
for FILE in "$FASTQ_DIR"/*.fastq.gz; do
    BASENAME=$(basename "$FILE" ".fastq.gz")
    fastp -i "$FILE" -o "$OUTPUT_DIR/${BASENAME}.fastq.gz"
done
