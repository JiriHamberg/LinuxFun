#! /bin/bash

if ! [[ $1 =~ ^[0-9]+$ ]] || [ $# -gt 1 ] || [ $# -lt 1 ]
then
	echo "Please give a single positive integer argument"
	exit 1
fi

head shortcat.txt
  
for i in $(seq 1 $1)
do
	sed -n '11p' shortcat.txt
done

tail -n 8 shortcat.txt | head -n 7

if [ $1 -gt 1 ]
then
	tail -n 1 shortcat.txt | sed s/Shortcat/Longcat/
else
	tail -n 1 shortcat.txt
fi