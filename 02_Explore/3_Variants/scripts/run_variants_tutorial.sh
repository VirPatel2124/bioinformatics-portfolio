#!/bin/bash
mkdir -p ~/02_Explore/3_Variants && cd ~/02_Explore/3_Variants
run() { echo "\$ $*"; eval "$*"; echo; }
CUT=/courses/BIOL2406.202710/shared/cutadapt_env
ANG=/courses/BIOL2406.202710/shared/angsd_env
echo "# Copy the Sea_cuke files from the course data folder into my own directory"
run "cp /courses/BIOL2406.202710/data/Sea_cuke/* ."
run "ls"
echo "# Unzip the genome and read files"
run "gunzip *.gz"
run "ls"
echo "# Header information of the genome sequence (first 3 header lines, number of sequences)"
run "grep '>' Ppar_tinygenome.fna | head -n 3 | cut -c1-120"
run "grep -c '>' Ppar_tinygenome.fna"
echo "# What the read files look like (first 8 lines = 2 reads)"
run "head -n 8 SRR6805880.tiny.fastq"
echo "# How many reads are in each fastq file (lines / 4)"
run "for f in *.tiny.fastq; do echo \$f \$(( \$(wc -l < \$f) / 4 )); done"
echo "# RAW READ QUALITY CONTROL: load fastqc and run it on one file"
module load fastqc/0.12.1
run "fastqc SRR6805880.tiny.fastq 2>&1"
run "ls"
echo "# Run fastqc on the remaining files with the wildcard"
run "fastqc SRR680588*.fastq 2>&1"
echo "# TRIMMING: the first bases of every read are identical (TGCAG, a restriction-site/adapter remnant)"
run "head -n 20 SRR6805881.tiny.fastq | awk 'NR%4==2' | cut -c1-30"
echo "# Activate cutadapt conda environment (anaconda module, then source activate)"
module load anaconda3/2024.06
source activate $CUT
echo "# Test cutadapt on one file"
run "cutadapt -g TGCAG SRR6805880.tiny.fastq -o SRR6805880.tiny_trimmed.fastq 2>&1 | head -n 25"
echo "# Trim all read files with a for loop"
for filename in *.tiny.fastq; do
  base=$(basename $filename .tiny.fastq)
  echo "\$ cutadapt -g TGCAG ${base}.tiny.fastq -o ${base}.tiny_trimmed.fastq"
  cutadapt -g TGCAG ${base}.tiny.fastq -o ${base}.tiny_trimmed.fastq 2>&1 | grep -E "Total reads processed|Reads with adapters|Total basepairs processed|Total written"
  echo
done
echo "# Check the trimmed files and that read starts are no longer identical"
run "ls *trimmed*"
run "head -n 20 SRR6805881.tiny_trimmed.fastq | awk 'NR%4==2' | cut -c1-30"
conda deactivate
echo "# BUILD INDEX: load bowtie2 and index the genome"
module load bowtie2/2.5.4 samtools/1.21
run "mkdir -p index"
run "bowtie2-build Ppar_tinygenome.fna Ppar_tinygenome 2>&1 | tail -n 3"
run "mv Ppar_tinygenome*.bt2 index/"
run "ls index"
echo "# MAP trimmed reads with a for loop"
for filename in *.tiny_trimmed.fastq; do
  base=$(basename $filename .tiny_trimmed.fastq)
  echo "# sample ${base}"
  echo "\$ bowtie2 -x index/Ppar_tinygenome -U ${base}.tiny_trimmed.fastq -S ${base}.sam"
  bowtie2 -x index/Ppar_tinygenome -U ${base}.tiny_trimmed.fastq -S ${base}.sam 2>&1
  echo
done
echo "# Look at the first lines of one SAM file"
run "head -n 6 SRR6805880.sam | cut -c1-140"
echo "# SAM to sorted BAM conversion with samtools"
for filename in *.sam; do
  base=$(basename $filename .sam)
  echo "\$ samtools view -bhS ${base}.sam | samtools sort -o ${base}.bam"
  samtools view -bhS ${base}.sam | samtools sort -o ${base}.bam
done
run "ls *.bam"
echo "# GENOTYPE LIKELIHOODS: activate angsd env, make bam file list"
source activate $ANG
run "ls *.bam > bam.filelist"
run "cat bam.filelist"
echo "# Run angsd to calculate genotype likelihoods and call SNPs (p-value 1e-2)"
run "angsd -bam bam.filelist -GL 1 -out genotype_likelihoods -doMaf 2 -SNP_pval 1e-2 -doMajorMinor 1 2>&1 | tail -n 5"
run "ls genotype_likelihoods*"
echo "# Look at the MAF file (minor allele frequencies) and count SNPs"
run "zcat genotype_likelihoods.mafs.gz | head -n 6"
run "zcat genotype_likelihoods.mafs.gz | tail -n +2 | wc -l"
