#!/bin/bash

# Author: Dr. Kristina Gagalova
# Command line tool to run ECpred

INPUT_FASTA=$1
NAME=$2

java -jar /opt/ECPred/ECPred.jar weighted ${INPUT_FASTA} /opt/ECPred/ /tmp ${NAME}_ecpred.out
