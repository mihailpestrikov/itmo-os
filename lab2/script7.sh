#!/bin/bash

start_mem=()
end_mem=()

pids=()
cmdline=()


for pid in $(ps -axo pid | tail -n +2); do

if [[ -r /proc/$pid/io ]]; then
	start_mem[$pid]=$(grep -s "rchar:" /proc/$pid/io | awk '{print $2}')
	pids[$pid]=$pid
	cmdline[$pid]=$(cat /proc/$pid/cmdline | tr -d '\0')
fi
done


sleep 10


for pid in "${pids[@]}"; do

	end_mem[$pid]=$(grep -s "rchar:" /proc/$pid/io | awk '{print $2}')
done


for pid in "${pids[@]}"; do

	diff=$(echo "${end_mem[$pid]} - ${start_mem[$pid]}" | bc)
	echo $pid $diff ${cmdline[$pid]}

done | sort -rn -k 2 | head -n 3


