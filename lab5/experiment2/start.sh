#!/bin/bash

for (( i=0; i < $1; i++ )); do
   ./newmem.sh $2 &
done
