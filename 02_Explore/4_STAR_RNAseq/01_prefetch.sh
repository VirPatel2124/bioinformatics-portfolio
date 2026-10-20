#!/bin/bash
#SBATCH -J pfVP
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -o output_%j.txt
#SBATCH -e error_%j.txt
#SBATCH -t 24:00:00

module load sratoolkit/12Dec2024
prefetch --option-file accessions.txt
