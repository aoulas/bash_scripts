samtools view nBM02.BCR.all_contig.bam | awk '{if ($5==255){ print $0}}' > nBM02.BCR.all_contigfiltered.sam
samtools view -H nBM02.BCR.all_contig.bam > header_filtered_sam
cat header_filtered_sam nBM02.BCR.all_contigfiltered.sam > nBM02.BCR.all_contigfilteredFinal.sam
samtools view -b nBM02.BCR.all_contigfilteredFinal.sam > nBM02.BCR.all_contigfilteredFinal.bam
