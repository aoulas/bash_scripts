htseq-count-barcodes EGAF00007297605/nBM02.BCR.all_contig.bam EGAF00007297605/testGFF.gff > EGAF00007297605/countsUMICorr.txt

cat EGAF00007297605/countsUMICorr.txt | head -n 1 | tr "\t" "\n" > EGAF00007297605/temp1.txt
cat EGAF00007297605/countsUMICorr.txt | head -n 2 | tail -1 | tr "\t" "\n" > EGAF00007297605/temp2.txt
paste -d "\t" EGAF00007297605/temp1.txt EGAF00007297605/temp2.txt > EGAF00007297605/countsUMICorrFinal.txt
