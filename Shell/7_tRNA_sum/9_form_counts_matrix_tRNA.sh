#!/bin/bash
#SBATCH -c 4
#SBATCH --mem-per-cpu=32G

summary_files=("C7_RT1.txt" "C7_RT2.txt" "C7_RT3.txt" "C7_RT4.txt" "C7_RT5.txt" "C7_TN1.txt" "C7_TN2.txt" "C7_TN3.txt" "C7_TN4.txt" "C7_TN5.txt" "C7_CE1.txt" "C7_CE2.txt" "C7_CE3.txt" "C7_CE4.txt" "C7_CE5.txt" "C7_CE6.txt" "C7_CE7.txt" "C7_CE8.txt" "C7_CE9.txt" "C7_CE10.txt")

sample_names=("C7_RT1" "C7_RT2" "C7_RT3" "C7_RT4" "C7_RT5" "C7_TN1" "C7_TN2" "C7_TN3" "C7_TN4" "C7_TN5" "C7_CE1" "C7_CE2" "C7_CE3" "C7_CE4" "C7_CE5" "C7_CE6" "C7_CE7" "C7_CE8" "C7_CE9" "C7_CE10")

patterns=("GtRNAdb-pre-tRNA_Match_Genome" "GtRNAdb-pre-tRNA_5_end_Match_Genome" "GtRNAdb-mature-tRNA_Match_Genome" "GtRNAdb-mature-tRNA_5_end_Match_Genome" "GtRNAdb-mature-tRNA_3_end_Match_Genome" "GtRNAdb-mature-tRNA_CCA_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_Match_Genome" "mitotRNAdb-mature-mt_tRNA_5_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_3_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_CCA_end_Match_Genome")

echo -e "tRNA\t${sample_names[@]}" | tr ' ' '\t' > tRNA_read_counts.txt

# Create an empty file to store all matched tRNA entries
> all_tRNA.txt

# Extract all tRNA entries that match the patterns
for file in "${summary_files[@]}"; do
    for pattern in "${patterns[@]}"; do
        awk -v pattern="$pattern" '$1 == pattern && $2 != "-" {print $2}' "$file" >> all_tRNA.txt
    done
done

sort all_tRNA.txt | uniq > matched_tRNA_list.txt
rm all_tRNA.txt

# Create the read count table for all matched tRNAs
while read -r gene; do
    line="$gene"
    for file in "${summary_files[@]}"; do
        value="0"
        for pattern in "${patterns[@]}"; do
            count=$(awk -v gene="$gene" -v pattern="$pattern" '$1 == pattern && $2 == gene {print $3}' "$file")
            if [ -n "$count" ] && [ "$count" != "-" ]; then
                value="$count"
                break
            fi
        done
        line="$line\t$value"
    done
    echo -e "$line" >> tRNA_read_counts.txt
done < matched_tRNA_list.txt

