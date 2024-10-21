#!/bin/bash
#These are the commands for configuring SLURM job parameters.
#Please adjust or remove them based on your actual runtime environment.
#SBATCH -o /to_your_directory/2_fastp_trim/2_fastp_trim.out
#SBATCH -e /to_your_directory/2_fastp_trim/2_fastp_trim.err
#SBATCH -c 8
#SBATCH --mem-per-cpu=32G

#Configure input and output directory.
in="/to_your_directory/0_raw_data"
out="/to_your_directory/2_fastp_trim"
mkdir -p "$out"

#Run fastp on the forward reads of all samples.
#The fastp trimming parametes are optimized based on our experiment sequencing data.
for x in "$in"/*_1.fq; do
	base_name=$(basename "$x" .fq)
	output="${out}/${base_name}.trimmed.fq"
	html="${out}/${base_name}.fastp.html"
	json="${out}/${base_name}.fastp.json"
fastp -i "$x" -o "$output" -h "$html" -j "$json" -a your_adapter_sequence -t 100 -5 -3 -M 30 -q 35 -w 16
done
