#!/bin/bash
#Specify the mapping result file; the text here is for illustration purpose only.
summary_files=("Condition1_Sample1.txt" "Condition1_Sample2.txt" "Condition1_Sample3.txt" "Condition2_Sample4.txt" "Condition2_Sample5.txt" "Condition2_Sample6.txt")

#Set the sample name, which will be your column name in the read counts matrix file.
sample_names=("Condition1_Sample1" "Condition1_Sample2" "Condition1_Sample3" "Condition2_Sample4" "Condition2_Sample5" "Condition2_Sample6")

#Specify the field names(patterns) that belong to tRNA and tsRNA.
patterns=("GtRNAdb-pre-tRNA_Match_Genome" "GtRNAdb-pre-tRNA_5_end_Match_Genome" "GtRNAdb-mature-tRNA_Match_Genome" "GtRNAdb-mature-tRNA_5_end_Match_Genome" "GtRNAdb-mature-tRNA_3_end_Match_Genome" "GtRNAdb-mature-tRNA_CCA_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_Match_Genome" "mitotRNAdb-mature-mt_tRNA_5_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_3_end_Match_Genome" "mitotRNAdb-mature-mt_tRNA_CCA_end_Match_Genome")

#Create a matrix file, write the header and column names, and use tab separation.
echo -e "tRNA\t${sample_names[@]}" | tr ' ' '\t' > tRNA_read_counts.txt

#Create an empty file to store all matched tRNA and tsRNA entries
> all_tRNA.txt

#Extract all tRNA and tsRNA entries that match the patterns;
#Generate the "matched_tRNA_list.txt" file, which contains all the mapped tRNA and tsRNA species in all samples.
for file in "${summary_files[@]}"; do
    for pattern in "${patterns[@]}"; do
        awk -v pattern="$pattern" '$1 == pattern && $2 != "-" {print $2}' "$file" >> all_tRNA.txt
    done
done

sort all_tRNA.txt | uniq > matched_tRNA_list.txt
rm all_tRNA.txt

#Extract the counts for each tRNA and tsRNA in its corresponding sample and write them into the previously created read counts matrix file, with values separated by tabs.
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

