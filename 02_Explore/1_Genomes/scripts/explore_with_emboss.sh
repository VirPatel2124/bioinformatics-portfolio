#!/bin/bash
cd ~/02_Explore/1_Genomes
run() { echo "\$ $*"; eval "$*"; echo; }
echo "# Load the anaconda module and check it loaded"
run module load anaconda3/2024.06
run module list 2>&1
echo "# Activate the emboss conda environment"
source activate /courses/BIOL2406.202710/shared/emboss_env
W=celegans/GCF_000002985.6_WBcel235_genomic.fna
B=borrelia/GCF_000008685.2_ASM868v2_genomic.fna
echo "# See what the worm file contains with infoseq"
run "infoseq $W"
echo "# Q1: How many sequences are in the worm genome? (count lines of infoseq output, minus header)"
run "infoseq $W -noheading -only -name | wc -l"
echo "# See what the Borrelia file contains with infoseq"
run "infoseq $B"
echo "# Q2: How many sequences are in the Borrelia genome?"
run "infoseq $B -noheading -only -name | wc -l"
echo "# Q3: Which worm sequence has the lowest GC%? (sort by %GC, show lowest)"
run "infoseq $W -noheading -only -name -length -pgc | sort -k3,3n | head -3"
echo "# Q4: Which Borrelia plasmid has the highest GC%? (sort by %GC, show highest; description shows what the sequence is)"
run "infoseq $B -noheading -only -name -length -pgc -desc | sort -k3,3nr | head -5"
echo "# Borrelia full table with descriptions (to interpret Q4)"
run "infoseq $B -noheading -only -name -length -pgc -desc"
echo "# Lambda phage genome and human genome summaries for Genomes_info"
run "infoseq lambda/GCF_000840245.1_ViralProj14204_genomic.fna"
run "infoseq human/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa -noheading -only -name -length -pgc | head -30"
echo "# Sea cucumber genome (needs unzipping first, done in Tutorial 3)"
