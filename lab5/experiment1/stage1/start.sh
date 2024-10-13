#!/bin/bash

rm *.log

./mem.sh&pid=$!
sleep 1
./parser.sh $pid
