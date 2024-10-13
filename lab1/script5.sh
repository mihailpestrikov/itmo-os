#!/bin/bash


log_file="/var/log/anaconda/syslog"
output_file="info.log"

grep 'INFO' "$log_file" > "$output_file"


