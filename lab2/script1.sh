#!/bin/bash

#ps -U root | wc -l > 1.txt

#ps -U root -o pid,cmd >> 1.txt

processes=$(ps -U root | tail -n +2)
count=$(echo "$processes" | wc -l)

echo $count > 1.txt
echo "$processes" | awk '{print $1" : "$4}' >> 1.txt

