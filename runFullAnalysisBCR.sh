acessionsfile=$1
dir=$(pwd)
while read -r line
do

    accession=$line;
    echo $accession;
    
    #pyega3 -cf ../ega_credential_file.json -c 20 fetch $accession

    #run htseq barcodes and save output in matrix format
    htseq-count-barcodes $accession/*.all_contigfilteredFinal.bam testGFF.gff > $accession/countsUMICorr.txt

    cat $accession/countsUMICorr.txt | head -n 1 | tr "\t" "\n" > $accession/temp1.txt
    cat $accession/countsUMICorr.txt | head -n 2 | tail -1 | tr "\t" "\n" > $accession/temp2.txt
    paste -d "\t" $accession/temp1.txt $accession/temp2.txt > $accession/countsUMICorrFinal.txt

    rm $accession/temp1.txt
    rm $accession/temp2.txt
    
    #Filter by removing all lines with 0 counts
    awk '{if($2 !=0){print $0}}' $accession/countsUMICorrFinal.txt > $accession/countsUMICorrFinalFiltered.txt
    linesinfile=$(cat $accession/countsUMICorrFinalFiltered.txt | wc -l)
    echo $linesinfile
    #extract all sequences from bam file
    samtools view $accession/*.all_contig.bam | cut -f 9- | cut -f 2- |  awk 'BEGIN {count=1;} {print ">"$4"_"count"\n"$1;count=count+1}' > $accession/AllSequences.fa

    count=1
    while read -r line
    do
    	toks=$(echo $line | tr "\t" "\n")
    	toks=(${line// / })
    	echo ${toks[0]} 
    	grep -F -A1 ${toks[0]} $accession/AllSequences.fa >> $accession/matchedSeq.fa
    	count=$((count+1))	
    	echo $count/$linesinfile	
    done < $accession/countsUMICorrFinalFiltered.txt

    
    
done < "$acessionsfile"
