#!/bin/bash
#SBATCH -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/1_fastqc/1_fastqc.out
#SBATCH -e /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/1_fastqc/1_fastqc.err
#SBATCH -c 16
#SBATCH --mem-per-cpu=4G

fastqc /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/0_raw_data/*T_1.fq \
	--nogroup -o /home/Sakai-lab/hao.lu.gv/workspace/sperm_cohort7/1_fastqc
