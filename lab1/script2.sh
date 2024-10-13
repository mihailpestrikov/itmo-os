#!/bin/bash

result=""

while true; do

read line

if [[ "$line" == "q" ]]; then
echo $result;
break
fi

result="$result $line"

done
