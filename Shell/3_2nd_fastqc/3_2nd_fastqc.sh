#!/bin/bash
#These are the commands for configuring SLURM job parameters.
#Please adjust or remove them based on your actual runtime environment.
#SBATCH -o /to_your_directory/3_2nd_fastqc/3_2nd_fastqc.out
#SBATCH -e /to_your_directory/3_2nd_fastqc/3_2nd_fastqc.err
#SBATCH -c 8
#SBATCH --mem-per-cpu=16G

#Run fastqc on the trimmed forward sequencing data.
fastqc /to_your_directory/0_fastp_data/*.fq \
	--nogroup -o /to_your_directory/3_2nd_fastqc -t 16
