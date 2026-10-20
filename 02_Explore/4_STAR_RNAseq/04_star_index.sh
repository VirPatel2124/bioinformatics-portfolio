#!/bin/bash
#SBATCH -J starindex
#SBATCH -N 2
#SBATCH -n 16
#SBATCH -o output_%j.txt
#SBATCH -e error_%j.txt
#SBATCH -t 24:00:00
#SBATCH --constraint=cascadelake

# TODO: set STAR_ENV to the STAR conda env in the course shared folder
STAR_ENV=/courses/BIOL2406.202710/shared/star_env
module load anaconda3/2024.06
source activate $STAR_ENV

# Paths: unzipped human fasta + gtf (edit to match your directories)
GENOME_FA=/home/patel.v9/02_Explore/1_Genomes/human/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa
GTF=/home/patel.v9/02_Explore/1_Genomes/human/Homo_sapiens.GRCh38.115.gtf

mkdir -p GenomeDir
STAR --runMode genomeGenerate --genomeDir GenomeDir \
     --genomeFastaFiles $GENOME_FA --sjdbGTFfile $GTF --runThreadN 16
