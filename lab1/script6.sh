#!/bin/bash


log_file="/var/log/anaconda/X.log"
output_file="full.log"

grep 'WW' "$log_file" | grep -Ev 'warning' | sed 's/(WW)/Warning:/' > "$output_file"
grep 'II' "$log_file" | grep -Ev 'information' | sed 's/(II)/Information:/' >> "$output_file"

