#!/bin/bash

for summary in *.txt; do
	shorter_name=$(echo "$summary" | sed 's/_T_1\.trimmed_summary//')
	mv "$summary" "$shorter_name"
done
