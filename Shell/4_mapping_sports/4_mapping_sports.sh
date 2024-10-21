#!/bin/bash
#SBATCH -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/4_mapping_sports/4_mapping_sports.out
#SBATCH -e /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/4_mapping_sports/4_mapping_sports.err
#SBATCH -c 6
#SBATCH --mem-per-cpu=24G

input_dir="/home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/0_fastp_data"
output_dir="/home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/4_mapping_sports"

mkdir -p "$output_dir"

for x in "$input_dir"/*.fq; do
	sports.pl -i "$x" -p 6 \
		-g /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/genome/mm10/genome \
		-m /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/miRBase/21/miRBase_21-mmu \
		-r /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/rRNAdb/mouse_rRNA \
		-t /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/GtRNAdb/mm10/mm10-tRNAs \
		-w /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/piRBase/piR_mouse \
		-e /home/Sakai-lab/hao.lu.gv/lib/sports1.1//Mus_musculus/Ensembl/release-89/Mus_musculus.GRCm38.ncrna \
		-f /home/Sakai-lab/hao.lu.gv/lib/sports1.1/Mus_musculus/Rfam/12.3/Rfam-12.3-mouse \
		-o "$output_dir" -k
	done
