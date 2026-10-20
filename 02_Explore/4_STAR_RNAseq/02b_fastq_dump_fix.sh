#!/bin/bash
#SBATCH -J fqfixVP
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -o output_%j.txt
#SBATCH -e error_%j.txt
#SBATCH -t 24:00:00

# Re-convert samples whose mate files had unequal read counts with --split-files.
# In these runs some spots have a 0-length mate, so --split-files gave mismatched _1/_2 files
# (STAR needs equal pairs). --split-3 writes matched pairs to _1/_2 and orphan reads to a separate file.
module load sratoolkit/12Dec2024

for acc in SRR1039513 SRR1039516 SRR1039520 SRR1039521;
do
    rm -f fastq_files/${acc}_1.fastq fastq_files/${acc}_2.fastq
    fasterq-dump --split-3 --outdir fastq_files "$acc"
done

# check that every pair now has the same number of reads
for acc in SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516 SRR1039517 SRR1039520 SRR1039521;
do
    echo $acc reads_1 $(( $(wc -l < fastq_files/${acc}_1.fastq) / 4 )) reads_2 $(( $(wc -l < fastq_files/${acc}_2.fastq) / 4 ))
done
