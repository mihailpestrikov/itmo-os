#!/bin/bash

PID=$(echo $$)

$1 &>/dev/null

sleep 10

if [[ $(ps --no-headers --ppid "$PID") ]]; then

	echo "exists"

else

	echo "does not exist"

fi



