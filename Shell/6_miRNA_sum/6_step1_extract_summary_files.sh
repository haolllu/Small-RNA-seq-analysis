#!/bin/bash
#Extract and copy the small RNA mapping results for each sample from the SPORTS1.1 output.
find /to_your_directory/4_mapping_sports -type f -wholename "*/*trimmed/*result/*summary.txt" -exec cp {} ./ \;
