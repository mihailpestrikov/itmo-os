#!/bin/bash

array=()
steps=0
PID=$$

while true; do
    array+=(1 2 3 4 5 6 7 8 9 10)
    let steps++
    if [[ $steps == 10000 ]]; then
	echo "${#array[@]}" >> report.log
	steps=0

        swap=$(free | awk '/Swap/{print $4}')
        if [[ $swap -eq 0 ]]; then
	    echo "Out of memory: Killed process $PID"
	    exit 0
        fi
    fi

done
