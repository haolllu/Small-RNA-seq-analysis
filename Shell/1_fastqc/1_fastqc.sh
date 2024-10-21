#!/bin/bash
#These are the commands for configuring SLURM job parameters.
#Please adjust or remove them based on your actual runtime environment.
#SBATCH -o /to_your_directory/1_fastqc/1_fastqc.out
#SBATCH -e /to_your_directory/1_fastqc/1_fastqc.err
#SBATCH -c 16
#SBATCH --mem-per-cpu=4G

#Run fastqc on the raw sequencing data;
#We are only using the forward reads from the paired-end sequencing data.
fastqc /to_your_directory/0_raw_data/*_1.fq \
	--nogroup -o /to_your_directory/1_fastqc
