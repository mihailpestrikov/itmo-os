#!/bin/bash

current_ppid=0
avg_sum=0
avg=0
count=1


while IFS= read line; do

pid=$(echo $line | awk -F '[= ]' '{print $2}')
ppid=$(echo $line | awk -F '[= ]' '{print $5}')
art=$(echo $line | awk -F '[= ]' '{print $8}')

if [[ $ppid == $current_ppid ]]; then

	avg_sum=$(echo "$avg_sum + $art" | bc)
	count=$(($count+1))
else

	avg=$(echo "scale=4; $avg_sum / $count" | bc | awk '{printf "%.4f", $0}')
	echo "Average_Running_Time_Of_ParentID="$current_ppid" is "$avg
	avg_sum=$art
	current_ppid=$ppid
	count=1
fi

if [[ -n $pid ]]; then

	echo "ProcessID="$pid" : Parent_ProcessID="$ppid" : Average_Runnng_Time="$art

fi

done < 4.txt > 5.txt
