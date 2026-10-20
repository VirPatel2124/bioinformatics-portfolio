#!/bin/bash
#SBATCH -J staralign
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -o output_%j.txt
#SBATCH -e error_%j.txt
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=12:00:00
#SBATCH --constraint=cascadelake

STAR_ENV=/courses/BIOL2406.202710/shared/star_env   # same as indexing script
module load anaconda3/2024.06
source activate $STAR_ENV

GENOME_DIR="GenomeDir"
FASTQ_DIR="fastq_files"
OUT_DIR="aligned_output"
mkdir -p "$OUT_DIR"

for read1 in "$FASTQ_DIR"/*_1.fastq; do
    sample=$(basename "$read1" _1.fastq)
    read2="$FASTQ_DIR/${sample}_2.fastq"
    STAR --genomeDir "$GENOME_DIR" \
         --readFilesIn "$read1" "$read2" \
         --runThreadN 16 \
         --outFileNamePrefix "$OUT_DIR/${sample}_" \
         --outSAMtype BAM SortedByCoordinate \
         --limitBAMsortRAM 40000000000
done
