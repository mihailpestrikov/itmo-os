#!/bin/bash

mkfifo pipe

sh handler.sh & sh generator2.sh

rm pipe
