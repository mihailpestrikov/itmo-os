#!/bin/bash
if [[ $1 -ne "" ]]; then
case $1 in
1)
nano
;;
2)
vi
;;
3)
links
;;
4)
break
;;
*)
echo "unexpected input"
;;
esac
fi

while true; do

echo "1. nano"
echo "2. vi"
echo "3. links"
echo "4. exit"

read choice

case $choice in
1)
nano
;;
2)
vi
;;
3)
links
;;
4)
break
;;
*)
echo "unexpected input"
;;
esac

done

