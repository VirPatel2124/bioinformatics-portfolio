#!/bin/bash
#SBATCH -J fqVP
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -o output_%j.txt
#SBATCH -e error_%j.txt
#SBATCH -t 24:00:00

module load sratoolkit/12Dec2024
for acc in SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516 SRR1039517 SRR1039520 SRR1039521
do
    fasterq-dump --split-files --outdir fastq_files "$acc"
done
