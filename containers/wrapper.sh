#!/usr/bin/bash

# Author: Dr. Kristina Gagalova - CCDM, Perth, Australia
# Command line wrapper tool to run ECpred

# Function to display usage information
usage() {
    echo "Usage: $0 <input_type> <input_file> <output_name>"
    echo "  input_type: weighted | blast | spmap | pepstats"
    echo "  input_file: Path to the input FASTA file"
    echo "  output_name: Name suffix for the output file"
}

# Check if correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    usage
    exit 1
fi

# Assign input arguments to variables
INPUT_TYPE=$1
INPUT_FASTA=$2
OUTPUT_NAME=$3

# Validate input type
if [[ ! "$INPUT_TYPE" =~ ^(weighted|blast|spmap|pepstats)$ ]]; then
    echo "Error: Invalid input type. Allowed values: weighted, blast, spmap, pepstats"
    usage
    exit 1
fi

# Run ECpred based on input type
case "$INPUT_TYPE" in
    weighted)
        java -jar /opt/ECPred/ECPred.jar weighted "$INPUT_FASTA" /opt/ECPred/ /tmp "${OUTPUT_NAME}_ecpred.out"
        ;;
    blast)
        java -jar /opt/ECPred/ECPred.jar blast "$INPUT_FASTA" /opt/ECPred/ /tmp "${OUTPUT_NAME}_ecpred.out"
        ;;
    spmap)
        java -jar /opt/ECPred/ECPred.jar spmap "$INPUT_FASTA" /opt/ECPred/ /tmp "${OUTPUT_NAME}_ecpred.out"
        ;;
    pepstats)
        java -jar /opt/ECPred/ECPred.jar pepstats "$INPUT_FASTA" /opt/ECPred/ /tmp "${OUTPUT_NAME}_ecpred.out"
        ;;
    *)
        echo "Error: Invalid input type. Allowed values: weighted, blast, spmap, pepstats"
        usage
        exit 1
        ;;
esac
