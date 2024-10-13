#!/bin/bash

while true; do

	read line
	echo "$line" > pipe

	if [[ "$line" == "QUIT" ]]; then

		echo "stopped by QUIT input: generator"
		exit 0

	fi

	if [[ "$line" != "+" && "$line" != "*" && "$line" != [0-9]* ]]; then
		echo "incorrent input: generator"
		exit 1
	fi
done
