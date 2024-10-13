#!/bin/bash

ps -eo pid,cmd | grep "/sbin" | awk '{print $1}' > 2.txt

