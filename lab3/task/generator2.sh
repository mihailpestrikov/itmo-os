#!/bin/bash

while true; do

	read line
	echo "generator2: $line" > pipe

	if [[ "$line" == "QUIT" ]]; then
		echo "generator2: QUIT"
		exit 0
	fi

done
