#!/bin/bash
man bash | grep -Eo '\b\w{4,}\b' | awk '{++freq[$0]} END {for (word in freq) print word, freq[word]}' | sort -k2nr | head -n 3

