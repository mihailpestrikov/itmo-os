#!/bin/bash

date=$(date '+%F_%R')

mkdir ~/test && echo "catalog test was created successfully" > ~/report && touch ~/test/$date

ping net_nikogo.ru || echo "$date unavailable" >> ~/report
