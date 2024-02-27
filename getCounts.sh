bamfile=$1;
barcodes=$2;

name="$bamfile"
replace_str=""
file=${name/.bam/$replace_str};
path=${name///*/$replace_str};

firstline=1;
lastline=1000000;

i=0;
i2=0;
tr=30;
while read -r line
do
    echo $line;
    i=$((i+1))
    i2=$((i2+1))
    barcodesarr[${i2}]=$line    
    samtools view $bamfile | cut -f 12- | grep $line | tr "\t" "\n" | grep "GX:Z" |awk '{count[$1]++} END {for(j in count) print count[j],j}' | sort -nr > $path"/"feature_counts_extracted_bam$i.txt &
    #| head -n $lastline | tail -n $(( $lastline -$firstline + 1 ))
    pids[${i}]=$!

    if (( $i % $tr == 0 ))
    then
	for pid in ${pids[*]}; do
            wait $pid
            echo "Waiting for "$pid            
	done

	
	pids=();
	echo "Next "$tr;
	
	for ((k=1; k<=$tr; k++))
	do	    	    
	    sed -e 's/$/ '${barcodesarr[$k]}'/' -i $path"/"feature_counts_extracted_bam$((i-tr+k)).txt;
	    cat $path"/"feature_counts_extracted_bam$((i-tr+k)).txt >> $path"/"feature_counts_extracted_bamAll.txt;
	    rm $path"/"feature_counts_extracted_bam$((i-tr+k)).txt;
	done
	barcodesarr=();
	i2=0;
    fi
done < "$barcodes"




