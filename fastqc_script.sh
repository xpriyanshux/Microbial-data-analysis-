#install fastqc

sudo apt -get update
sudo apt-get install fastqc

vi fastqc_script
#!/bin/bash

# Directory containing the FASTQ files
FASTQ_DIR="/path/to/your/fastq/files"
# Directory to store the FastQC output
OUTPUT_DIR="/path/to/output/directory"
# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
# Run FastQC on all FASTQ files in the directory
fastqc -o "$OUTPUT_DIR" "$FASTQ_DIR"/*.fastq "$FASTQ_DIR"/*.fastq.gz

