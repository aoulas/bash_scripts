awk '{if($0 ~ /Sequences producing significant alignments/){getline; getline; print $0}}' EGAF00007297605/BlastOut.txt
