#!/bin/bash

operation="+"
value=1
tail -f pipe |
while true; do

	read line

	case $line in
	"+") operation="+"; echo "addition";;
	"*") operation="*"; echo "multiplication";;
	"QUIT") echo "stopped by QUIT input: handler"; killall tail; exit 0;;
	[0-9]*)
		if [[ "$operation" == "+" ]]; then
			value=$(($value + $line))
		fi
		if [[ "$operation" == "*" ]]; then
			value=$(($value * $line))
		fi
		echo $value;;
	*) echo "incorrect input: handler"; killall tail; exit 1;;
	esac

done
