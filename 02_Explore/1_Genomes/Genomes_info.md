# Genomes_info

Information for the five reference genomes used in the Explore assignment (sizes/gene counts from the NCBI Datasets assembly reports and from emboss `infoseq` output; human protein-coding genes counted from the Ensembl 115 GTF).

## 1. *Borreliella (Borrelia) burgdorferi* B31 (Lyme disease bacterium), GCF_000008685.2
- **Size:** 1,521,208 bp (1.52 Mb)
- **Structure:** 22 replicons: one linear chromosome (910,724 bp) + 21 plasmids (linear lp and circular cp types, 5-54 kb)
- **Estimated protein-coding genes:** 1,456 (1,568 total genes)
- **Access:** NCBI Genome / assembly ASM868v2; FTP: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/008/685/GCF_000008685.2_ASM868v2/

## 2. *Caenorhabditis elegans* (Bristol N2), GCF_000002985.6
- **Size:** 100,272,607 bp (~100 Mb)
- **Structure:** 7 sequences: 5 autosomes (I-V) + X chromosome (linear) + a circular mitochondrial genome (13,794 bp); no plasmids
- **Estimated protein-coding genes:** 19,983 (46,926 total genes incl. non-coding)
- **Access:** NCBI Genome / assembly WBcel235; FTP: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/985/GCF_000002985.6_WBcel235/

## 3. *Parastichopus parvimensis* (sea cucumber)
- **Size:** 83,511,562 bp in the course subsample (Ppar_tinygenome.fna); a subset of the full assembly, so much smaller than the full genome
- **Structure:** 2,000 unplaced scaffolds/contigs (whole genome shotgun assembly; no chromosome-level structure); no plasmids
- **Estimated protein-coding genes:** not available for this subsample (no annotation provided with the course data)
- **Access:** course data directory: /courses/BIOL2406.202710/data/Sea_cuke/ (copied into my directory)

## 4. *Homo sapiens* GRCh38 (human), GCA_000001405.29
- **Size:** 3,099,734,149 bp (~3.1 Gb) for the full GRCh38.p14 assembly (the Ensembl primary assembly used here is ~3.1 Gb)
- **Structure:** 24 linear nuclear chromosomes (1-22, X, Y) + circular mitochondrial genome (16,569 bp); the primary assembly file also contains unplaced/unlocalized scaffolds
- **Estimated protein-coding genes:** 20,121 (counted from Ensembl release 115 GTF)
- **Access:** Ensembl release 116: https://ftp.ensembl.org/pub/release-116/fasta/homo_sapiens/dna/ (Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz); annotation: Homo_sapiens.GRCh38.115.gtf.gz from Ensembl release 115

## 5. Lambda phage (Enterobacteria phage lambda), NC_001416.1 (assembly GCF_000840245.1)
- **Size:** 48,502 bp
- **Structure:** single linear double-stranded DNA molecule (it circularizes in the host cell); 1 sequence, no plasmids
- **Estimated protein-coding genes:** 73 (92 total features)
- **Access:** NCBI Nucleotide NC_001416.1 / FTP: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/840/245/GCF_000840245.1_ViralProj14204/
