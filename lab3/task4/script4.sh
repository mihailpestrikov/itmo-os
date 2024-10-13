sh loop.sh & pid1=$!
sh loop.sh & pid2=$!
sh loop.sh & pid3=$!

renice +10 -p $pid1

echo $pid1 $pid2 $pid3
