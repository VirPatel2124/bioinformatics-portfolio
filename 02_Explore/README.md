# 02_Explore - Genome Analysis on Explorer (BIOL 2406)

Vir Patel (patel.v9) - Assignment 2: basic tools for managing and analyzing genomic sequences on Northeastern's Explorer HPC cluster.

## Layout
| Folder | What is in it |
|---|---|
| `1_Genomes/` | `Genomes_info.md` (size, structure, genes, access for the 5 genomes); `session_genomes.txt` (hash-commented session with the emboss commands/output and answers to the 5 questions); `scripts/` (download + emboss scripts); data subfolders `borrelia/ celegans/ lambda/ human/ reads/ sea_cuke/` (sequence files, not pushed) |
| `2_bowtie2_lambda/` | `session_bowtie2.txt` (hash-commented session: peek at files, genome length, read counts, bowtie2-build, align, samtools, bcftools); `variants.txt`; `scripts/run_bowtie2_tutorial.sh` |
| `3_Variants/` | `session_variants.txt` (fastqc, cutadapt, bowtie2, samtools, angsd); `session_inclass.txt` + `inclass_answers.txt` (in-class exercises, incl. the SNP p-values tried); `scripts/` |
| `4_STAR_RNAseq/` | batch scripts (`01_prefetch.sh`, `02_fastq_dump.sh`, `04_star_index.sh`, `05_star_align.sh`), `accessions.txt`, and notes on read quality (`fastqc_notes.txt`) |

## Notes
- Tools: modules `anaconda3/2024.06`, `bowtie2/2.5.4`, `samtools/1.21`, `bcftools/1.21`, `fastqc/0.12.1`, `sratoolkit/12Dec2024`; conda envs in `/courses/BIOL2406.202710/shared/` (`emboss_env`, `cutadapt_env`, `angsd_env`, `star_env`).
- Tutorial 4's large data (SRA reads, fastq, STAR index, aligned BAMs) are in `/scratch/patel.v9/4_STAR_RNAseq/` because they exceed the home-directory quota. The scripts in this repo are the ones run there.
- The STAR batch scripts include `#SBATCH --constraint=cascadelake`: the course STAR build crashed with "Illegal instruction" on older nodes.
- Sequence/data files (fa, fastq, gtf, sam, bam, bt2, ...) are excluded by `.gitignore`.
