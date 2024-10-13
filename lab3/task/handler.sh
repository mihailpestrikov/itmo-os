#!/bin/bash

tail -f pipe |
while true; do

	read line
	if [[ $(echo "$line" | awk '{print $2}') == "QUIT" ]]; then
		exit 0
	else
		echo "$line"
	fi
done
