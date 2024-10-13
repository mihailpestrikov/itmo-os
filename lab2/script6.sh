#!/bin/bash

max_mem=0
max_pid=0

for dir in /proc/*/; do

pid=$(basename "$dir")

if [[ -r "$dir/status" ]]; then

mem=$(grep -s "VmRSS:" "$dir/status" | awk '{print $2}')

if [[ -n "$mem" && "$mem" -gt "$max_mem" ]]; then
max_mem="$mem"
max_pid="$pid"
fi

fi

done

echo "PID: $max_pid, MEM: $max_mem KB"
