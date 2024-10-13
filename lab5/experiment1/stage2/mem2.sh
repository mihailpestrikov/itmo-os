#!/bin/bash

array=()
steps=0
count=0
PID=$$

while true; do
    array+=(1 2 3 4 5 6 7 8 9 10)
    let steps++
    if [[ $steps == 10000 ]]; then
	echo "${#array[@]}" >> report2.log
	steps=0

        swap=$(free | awk '/Swap/{print $4}')
        if [[ $swap -eq 0 ]] && [[ $count -eq 0 ]]; then
	    let count++
	    continue
	fi
	if [[ $swap -eq 0 ]] && [[ $count -eq 1 ]]; then
	    echo "Out of memory: Killed process $PID"
	    exit 0
	fi
    fi

done
