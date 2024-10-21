#!/bin/bash
#Specify the mapping result file; the text here is for illustration purpose only.
summary_files=("Condition1_Sample1.txt" "Condition1_Sample2.txt" "Condition1_Sample3.txt" "Condition2_Sample4.txt" "Condition2_Sample5.txt" "Condition2_Sample6.txt")

#Set the sample name, which will be your column name in the read counts matrix file.
sample_names=("Condition1_Sample1" "Condition1_Sample2" "Condition1_Sample3" "Condition2_Sample4" "Condition2_Sample5" "Condition2_Sample6")

#Create a matrix file, write the header and column names, and use tab separation.
echo -e "miRNA\t${sample_names[@]}" | tr ' ' '\t' > miRNA_read_counts.txt

#Generate the "matched_miRNA_list.txt" file, which contains all the mapped microRNA species in all samples.
for file in "${summary_files[@]}"; do
	awk '$1 == "miRBase-miRNA_Match_Genome" && $2 != "-" {print $2}' "$file" >> all_miRNA.txt
done

sort all_miRNA.txt | uniq > matched_miRNA_list.txt
rm all_miRNA.txt

#Extract the counts for each microRNA in its corresponding sample and write them into the previously created read counts matrix file, with values separated by tabs.
while read -r gene; do
	line="$gene"
	for file in "${summary_files[@]}"; do
		value=$(awk -v gene="$gene" '$1 == "miRBase-miRNA_Match_Genome" && $2 == gene {print $3}' "$file")
		if [ -z "$value" ] || [ "$value" = "-" ]; then
			value="0"
		fi
		line="$line\t$value"
	done
	echo -e "$line" >> miRNA_read_counts.txt
done < matched_miRNA_list.txt

