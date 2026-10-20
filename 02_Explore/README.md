# Explore (Assignment 2) - Vir Patel (patel.v9)

Basic tools for managing and analyzing genomic sequences on Explorer (BIOL 2406). This folder holds only the submission files
(sessions, scripts, answers, notes); large data files are not included.

| Folder | Contents |
|---|---|
| `1_Genomes/` | `Genomes_info.md`; `session_genomes.txt` (hash-commented session with the emboss commands/output and answers to the 5 questions); `scripts/` |
| `2_bowtie2_lambda/` | `session_bowtie2.txt` (hash-commented session); `variants.txt`; `scripts/` |
| `3_Variants/` | `session_variants.txt`; `session_inclass.txt` + `inclass_answers.txt` (in-class exercises, SNP p-values tried); `scripts/` |
| `4_STAR_RNAseq/` | batch scripts (`01_prefetch.sh`, `02_fastq_dump.sh`, `02b_fastq_dump_fix.sh`, `04_star_index.sh`, `05_star_align.sh`), `accessions.txt`, `fastqc_notes.txt`, `fastqc_out/` (FastQC reports for SRR1039508 and SRR1039516) |

## Notes
- Tools: modules `anaconda3/2024.06`, `bowtie2/2.5.4`, `samtools/1.21`, `bcftools/1.21`, `fastqc/0.12.1`, `sratoolkit/12Dec2024`; conda envs in `/courses/BIOL2406.202710/shared/` (`emboss_env`, `cutadapt_env`, `angsd_env`, `star_env`).
- Tutorial 4 data (SRA reads, fastq files, STAR index, aligned BAMs) are in `/scratch/patel.v9/4_STAR_RNAseq/` because they exceed the home-directory quota. The scripts here are the ones run there.
- Changes from the provided scripts: (1) `02b_fastq_dump_fix.sh` re-converts SRR1039513, 516, 520 and 521 with `fasterq-dump --split-3`, because `--split-files` gave unequal read counts in the _1/_2 files (some spots have a 0-length mate); all 8 pairs were checked to have equal counts. (2) The STAR scripts have `#SBATCH --constraint=cascadelake` because the course STAR build crashed with "Illegal instruction" on older nodes.

## Status of Tutorial 4 at submission (11:20 PM, Oct 19)
- Done: SRA download (`01_prefetch.sh`), fastq conversion (`02_fastq_dump.sh`, then `02b_fastq_dump_fix.sh`; all 8 read pairs verified equal), FastQC on two samples with notes (`fastqc_notes.txt`).
- Still running: the STAR human genome index (`04_star_index.sh`, job 11247994, ~1 h 40 min in, no errors). The STAR alignment (`05_star_align.sh`, job 11247997) is queued and starts automatically when the index finishes; its output will be written to `/scratch/patel.v9/4_STAR_RNAseq/aligned_output/`. The alignment had not started at the time of this note.
