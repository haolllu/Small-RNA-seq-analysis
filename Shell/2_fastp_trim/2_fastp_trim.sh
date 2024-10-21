#!/bin/bash
#SBATCH -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/2_fastp_trim/2_fastp_trim.out
#SBATCH -e /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/2_fastp_trim/2_fastp_trim.err
#SBATCH -c 8
#SBATCH --mem-per-cpu=32G

in="/home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/0_raw_data"
out="/home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/2_fastp_trim"

mkdir -p "$out"

for x in "$in"/*_1.fq; do
	base_name=$(basename "$x" .fq)
	output="${out}/${base_name}.trimmed.fq"
	html="${out}/${base_name}.fastp.html"
	json="${out}/${base_name}.fastp.json"
fastp -i "$x" -o "$output" -h "$html" -j "$json" -a TGGAATTCTCGGGTGCCAAGG -t 100 -5 -3 -M 30 -q 35 -w 16
done
