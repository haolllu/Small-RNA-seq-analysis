#!/bin/bash
#Modify all extracted filenames to include only the condition and sample number.
for summary in *.txt; do
	shorter_name=$(echo "$summary" | sed 's/_1\.trimmed_summary//')
	mv "$summary" "$shorter_name"
done
