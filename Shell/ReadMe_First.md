### These folders contain Shell scripts that are run on a Linux system in a high-performance computing environment configured with the SLURM job scheduling system.
#### My folder structure is as follows:
***0_raw_data***: Stores the raw small-RNA paired-end sequencing data.  
***0_fastp_data***: Stores the trimmed small-RNA paired-end sequencing data outputed by ***fastp***.   
***1_fastqc***: Stores ***fastqc*** running script of raw sequencing data, outputed reports(.html, .zip) and an integrated report via ***multiqc***.  
***2_fastp_trim***: Stores ***fastp*** running script, outputed reports(.html, .jason) and an integrated report via ***multiqc***.  
***3_2nd_fastqc***: Stores ***fastqc*** runnning script of trimmed sequencing data, outputed reports(.html, .zip) and an integrated report via ***multiqc***.  
***4_mapping_sports***: Stores ***sports1.1*** runnning script and outputed mapping results.  
***5_distribution_sum***: Stores small-RNA mapping distribution reports (.pdf) of all samples and the corresponding script that extracts and copies them here.  
***6_miRNA_sum***: Stores small-RNA mapping summary(.txt) and read counts matrix of microRNA of all samples and scripts that can form them.  
***7_tRNA_sum***: Stores small-RNA mapping summary(.txt) and read counts matrix of tRNA and tsRNA of all samples and scripts that can form them.
