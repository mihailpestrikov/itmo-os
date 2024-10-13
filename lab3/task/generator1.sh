#!/bin/bash

while true; do

	read line

	echo "generator1: $line" > pipe

	if [[ "$line" == "QUIT" ]]; then
		echo "generator1: QUIT"
		exit 0
	fi

done

