#!/bin/bash
#SBATCH -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/3_2nd_fastqc/3_2nd_fastqc.out
#SBATCH -e /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/3_2nd_fastqc/3_2nd_fastqc.err
#SBATCH -c 8
#SBATCH --mem-per-cpu=16G

fastqc /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/0_fastp_data/*.fq \
	--nogroup -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/3_2nd_fastqc -t 16
