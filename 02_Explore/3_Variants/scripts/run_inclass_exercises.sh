#!/bin/bash
cd ~/02_Explore/3_Variants
run() { echo "\$ $*"; eval "$*"; echo; }
CUT=/courses/BIOL2406.202710/shared/cutadapt_env
ANG=/courses/BIOL2406.202710/shared/angsd_env
module load bowtie2/2.5.4 samtools/1.21 anaconda3/2024.06
echo "# IN-CLASS EXERCISE 1: map the UNTRIMMED reads to the genome (outputs go in untrimmed/)"
mkdir -p untrimmed
for filename in *.tiny.fastq; do
  base=$(basename $filename .tiny.fastq)
  echo "# sample ${base} (untrimmed)"
  echo "\$ bowtie2 -x index/Ppar_tinygenome -U ${base}.tiny.fastq -S untrimmed/${base}.untrimmed.sam"
  bowtie2 -x index/Ppar_tinygenome -U ${base}.tiny.fastq -S untrimmed/${base}.untrimmed.sam 2>&1
  echo
done
echo "# IN-CLASS EXERCISE 2: trim adapter AND shorten reads to 70 bp with cutadapt (-l 70), output named *.tiny_trimmed70.fastq"
source activate $CUT
mkdir -p trimmed70
for filename in *.tiny.fastq; do
  base=$(basename $filename .tiny.fastq)
  echo "\$ cutadapt -g TGCAG -l 70 ${base}.tiny.fastq -o trimmed70/${base}.tiny_trimmed70.fastq"
  cutadapt -g TGCAG -l 70 ${base}.tiny.fastq -o trimmed70/${base}.tiny_trimmed70.fastq 2>&1 | grep -E "Total reads processed|Reads with adapters|Total basepairs processed|Total written"
  echo
done
conda deactivate
echo "# Map the 70 bp trimmed reads"
for filename in trimmed70/*.tiny_trimmed70.fastq; do
  base=$(basename $filename .tiny_trimmed70.fastq)
  echo "# sample ${base} (trimmed to 70 bp)"
  echo "\$ bowtie2 -x index/Ppar_tinygenome -U trimmed70/${base}.tiny_trimmed70.fastq -S trimmed70/${base}.trimmed70.sam"
  bowtie2 -x index/Ppar_tinygenome -U trimmed70/${base}.tiny_trimmed70.fastq -S trimmed70/${base}.trimmed70.sam 2>&1
  echo
done
echo "# IN-CLASS EXERCISE 3: change the angsd SNP p-value (the original run used 1e-2 and kept 9 SNPs)"
source activate $ANG
mkdir -p snp_pvalues
for p in 1e-1 1e-3 1e-6; do
  echo "# SNP_pval = ${p}"
  echo "\$ angsd -bam bam.filelist -GL 1 -out snp_pvalues/gl_p${p} -doMaf 2 -SNP_pval ${p} -doMajorMinor 1"
  angsd -bam bam.filelist -GL 1 -out snp_pvalues/gl_p${p} -doMaf 2 -SNP_pval ${p} -doMajorMinor 1 2>&1 | grep -E "Total number of sites|retained after filtering"
  echo "\$ zcat snp_pvalues/gl_p${p}.mafs.gz | tail -n +2 | wc -l"
  zcat snp_pvalues/gl_p${p}.mafs.gz | tail -n +2 | wc -l
  echo
done
