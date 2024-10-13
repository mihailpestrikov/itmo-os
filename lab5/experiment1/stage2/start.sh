#!/bin/bash

rm *.log

./mem.sh&pid1=$!
./mem2.sh&pid2=$!
sleep 1
./parser.sh $pid1 $pid2
