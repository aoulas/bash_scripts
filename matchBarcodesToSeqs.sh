countsfile=$1;

#seqfile="EGAF00007297605/AllSequences.fa"
count=1
while read -r line
do
    #echo $line;
    toks=$(echo $line | tr "\t" "\n")
    toks=(${line// / })
    #echo ${toks[0]}    
    #awk '{if($2 !=0){print $1;grep $1 $seqfile" }}' $countsfile
    #echo ${toks[2]}
    #for tok in $toks
    #do
#	echo "$tok"
    #   done
    #if [[ ${toks[1]} != "0" ]]
    #then
    echo ${toks[0]} 
    grep -F -A1 ${toks[0]} EGAF00007297605/AllSequences.fa >> EGAF00007297605/matchedSeq.fa
    count=$((count+1))
    #count=$count+1
    echo $count/9455
    #fi
done < "$countsfile"
