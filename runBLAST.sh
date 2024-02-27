#makeblastdb -in refdata-cellranger-vdj-GRCh38-alts-ensembl-5.0.0/fasta/regions.fa -parse_seqids -dbtype nucl
blastn -num_threads 20 -query EGAF00007297605/matchedSeq.fa -out EGAF00007297605/BlastOutMathced.txt -db refdata-cellranger-vdj-GRCh38-alts-ensembl-5.0.0/fasta/regions.fa 
