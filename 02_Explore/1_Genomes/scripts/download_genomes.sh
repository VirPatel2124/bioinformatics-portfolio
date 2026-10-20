#!/bin/bash
cd ~/02_Explore/1_Genomes
N=https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF
run() { echo "\$ $*"; "$@"; }
echo "# Download B. burgdorferi genome (NCBI FTP, .fna.gz)"
run wget -nv -P borrelia $N/000/008/685/GCF_000008685.2_ASM868v2/GCF_000008685.2_ASM868v2_genomic.fna.gz
echo "# Download C. elegans genome (NCBI FTP, .fna.gz)"
run wget -nv -P celegans $N/000/002/985/GCF_000002985.6_WBcel235/GCF_000002985.6_WBcel235_genomic.fna.gz
echo "# Download lambda phage genome (NCBI FTP, .fna.gz)"
run wget -nv -P lambda $N/000/840/245/GCF_000840245.1_ViralProj14204/GCF_000840245.1_ViralProj14204_genomic.fna.gz
echo "# Copy Sea_cuke directory from course data folder"
run cp -r /courses/BIOL2406.202710/data/Sea_cuke sea_cuke/
echo "# Download human soft-masked genome from Ensembl"
run wget -nv -P human https://ftp.ensembl.org/pub/release-116/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
echo "# Download human GTF from Ensembl"
run wget -nv -P human https://ftp.ensembl.org/pub/release-115/gtf/homo_sapiens/Homo_sapiens.GRCh38.115.gtf.gz
echo "# Download lambda reads (raw GitHub links, bowtie2 examples/reads)"
run wget -nv -P reads https://raw.githubusercontent.com/BenLangmead/bowtie2/master/example/reads/reads_1.fq
run wget -nv -P reads https://raw.githubusercontent.com/BenLangmead/bowtie2/master/example/reads/reads_2.fq
echo "# Unzip the downloaded .gz files"
run gunzip borrelia/*.gz celegans/*.gz lambda/*.gz human/*.gz
echo "# List everything"
run ls -lhR
