#!/bin/bash
#These are the commands for configuring SLURM job parameters.
#Please adjust or remove them based on your actual runtime environment.
#SBATCH -o /to_your_directory/4_mapping_sports/4_mapping_sports.out
#SBATCH -e /to_your_directory/4_mapping_sports/4_mapping_sports.err
#SBATCH -c 6
#SBATCH --mem-per-cpu=24G

#Configure input and output directory.
input_dir="/to_your_directory/0_fastp_data"
output_dir="/to_your_directory/4_mapping_sports"
mkdir -p "$output_dir"

#Run sports1.1 on trimmed sequencing data for mapping them to corresponding species genome and specific small RNA database.
#The GitHub page of SPORTS1.1 provides databases for different species, and here the database for the mouse species is shown.
for x in "$input_dir"/*.fq; do
	sports.pl -i "$x" -p 6 \
		-g /to_your_directory/sports1.1/Mus_musculus/genome/mm10/genome \
		-m /to_your_directory/sports1.1/Mus_musculus/miRBase/21/miRBase_21-mmu \
		-r /to_your_directory/sports1.1/Mus_musculus/rRNAdb/mouse_rRNA \
		-t /to_your_directory/sports1.1/Mus_musculus/GtRNAdb/mm10/mm10-tRNAs \
		-w /to_your_directory/sports1.1/Mus_musculus/piRBase/piR_mouse \
		-e /to_your_directory/sports1.1//Mus_musculus/Ensembl/release-89/Mus_musculus.GRCm38.ncrna \
		-f /to_your_directory/sports1.1/Mus_musculus/Rfam/12.3/Rfam-12.3-mouse \
		-o "$output_dir" -k
	done
