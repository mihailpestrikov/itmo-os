#!/bin/bash

PPID=$$
PID=$(echo $$)

ps -eo pid,ppid,cmd,start_time --sort=start_time | grep -vE "$PPID|$PID" | tail -n 1 | awk '{print $1}' > 3.txt



