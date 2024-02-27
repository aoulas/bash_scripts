#Make blastdb
#makeblastdb -in regions.fa -parse_seqids -dbtype nucl

#samtools view EGAF00007297605/nBM02.BCR.all_contig.bam | cut -f 9- | cut -f 2- | cut -f -1 | head -n 100 | awk 'BEGIN {count=1;} {print ">Seq"count"\n"$1;count=count+1}' > EGAF00007297605/First100Seqs.fa

samtools view EGAF00007297605/nBM02.BCR.all_contig.bam | cut -f 9- | cut -f 2- |  awk 'BEGIN {count=1;} {print ">"$4"_"count"\n"$1;count=count+1}' > EGAF00007297605/AllSequences.fa


blastn -query EGAF00007297605/First100Seqs.fa -out EGAF00007297605/BlastOut.txt -num_alignments 0 -db refdata-cellranger-vdj-GRCh38-alts-ensembl-5.0.0/fasta/regions.fa 
