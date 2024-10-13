#!/bin/bash

for dir in /proc/*/; do

if [[ -r "$dir/sched" && -r "$dir/status" ]]; then

	pid=$(basename "$dir")

	ppid=$(grep -E '^PPid:' "$dir/status" | awk '{print $2}')

	sum_exec_runtime=$(grep -E '^se.sum_exec_runtime' "$dir/sched" | awk '{print $3}')
	nr_switches=$(grep -E '^nr_switches' "$dir/sched" | awk '{print $3}')

		if [[ -n $sum_exec_runtime && -n $nr_switches && $nr_switches -ne 0 ]]; then
			art=$(echo "scale=4; $sum_exec_runtime / $nr_switches" | bc)
		else
			art=0
		fi

	echo "$pid $ppid $art"

fi

done | sort -n -k 2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > 4.txt
