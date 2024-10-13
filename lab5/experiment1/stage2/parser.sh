#!/bin/bash

echo "free_m : used_m : free_s : used_s" > mem.log
echo "process1 : process2 : process3 : process4 : proccess5" > process.log
echo "time : mem" > memsh1.log
echo "time : mem" > memsh2.log

PID1=$1
PID2=$2

while true; do
    top -b -n 1 > TABLE

    LINE1=$(cat TABLE | grep "$PID1")
    LINE2=$(cat TABLE | grep "$PID1")

    FLAG1=0
    FLAG2=0

    if [[ "$(cat TABLE | grep "$PID1" | wc -l)" -eq "1" ]]; then
	FLAG1=1
	process_time=$(echo $LINE1 | awk '{print $11}')
	process_mem=$(echo $LINE1 | awk '{print $9}')
	echo "$process_time : $process_mem" >> memsh1.log
    fi

    if [[ "$(cat TABLE | grep "$PID2" | wc -l)" -eq "1" ]]; then
        FLAG2=1
        process_time=$(echo $LINE2 | awk '{print $11}')
        process_mem=$(echo $LINE2 | awk '{print $9}')
        echo "$process_time : $process_mem" >> memsh2.log
    fi

    if [[ "$FLAG1" -eq "1" || "$FLAG2" -eq "1" ]]; then
        process1=$(cat TABLE | sed -n '8p' | awk '{print $12}')
        process2=$(cat TABLE | sed -n '9p' | awk '{print $12}')
        process3=$(cat TABLE | sed -n '10p' | awk '{print $12}')
        process4=$(cat TABLE | sed -n '11p' | awk '{print $12}')
        process5=$(cat TABLE | sed -n '12p' | awk '{print $12}')
        echo "$process1 : $process2 : $process3 : $process4 : $process5" >> process.log


        mem_info=$(cat TABLE | grep "MiB Mem")
        swap_info=$(cat TABLE | grep "MiB Swap")
        free_mem=$(echo "$mem_info" | awk '{print $6}')
        used_mem=$(echo "$mem_info" | awk '{print $8}')
        free_swap=$(echo "$swap_info" | awk '{print $5}')
        used_swap=$(echo "$swap_info" | awk '{print $7}')
        echo "$free_mem : $used_mem : $free_swap : $used_swap" >> mem.log
    else
	rm TABLE
	exit 0
    fi
done
