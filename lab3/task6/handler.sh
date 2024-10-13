#!/bin/bash

operator="+"
value=1

TERM()
{
	exit 0
}

USR1()
{
	operator="+"
}

USR2()
{
	operator="*"
}

trap 'TERM' SIGTERM
trap 'USR1' USR1
trap 'USR2' USR2

while true; do

	case $operator in
	"+") value=$(($value + 2));;
	"*") value=$(($value * 2));;
	*) continue;;
	esac

	echo $value
	sleep 1

done
