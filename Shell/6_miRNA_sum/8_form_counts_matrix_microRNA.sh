#!/bin/bash
#SBATCH -c 4
#SBATCH --mem-per-cpu=32G

summary_files=("C7_RT1.txt" "C7_RT2.txt" "C7_RT3.txt" "C7_RT4.txt" "C7_RT5.txt" "C7_TN1.txt" "C7_TN2.txt" "C7_TN3.txt" "C7_TN4.txt" "C7_TN5.txt" "C7_CE1.txt" "C7_CE2.txt" "C7_CE3.txt" "C7_CE4.txt" "C7_CE5.txt" "C7_CE6.txt" "C7_CE7.txt" "C7_CE8.txt" "C7_CE9.txt" "C7_CE10.txt")

sample_names=("C7_RT1" "C7_RT2" "C7_RT3" "C7_RT4" "C7_RT5" "C7_TN1" "C7_TN2" "C7_TN3" "C7_TN4" "C7_TN5" "C7_CE1" "C7_CE2" "C7_CE3" "C7_CE4" "C7_CE5" "C7_CE6" "C7_CE7" "C7_CE8" "C7_CE9" "C7_CE10")

echo -e "miRNA\t${sample_names[@]}" | tr ' ' '\t' > miRNA_read_counts.txt

for file in "${summary_files[@]}"; do
	awk '$1 == "miRBase-miRNA_Match_Genome" && $2 != "-" {print $2}' "$file" >> all_miRNA.txt
done

sort all_miRNA.txt | uniq > matched_miRNA_list.txt
rm all_miRNA.txt

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

