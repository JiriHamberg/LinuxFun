#! /bin/bash
mintemp=100
minfile=""


for folder in $*
do
	for file in $(find $folder -name '*temps.txt')
	do
		#extract current files processor zone temp
		temp=$( grep "PROCESSOR_ZONE" < $file | sed 's/\ \+/ /g' | cut -d ' ' -f3 | cut -d "C" -f1 )
		if [ $temp -lt $mintemp ]; then
			mintemp=$temp
			minfile=$file
		fi
	done
done
echo "$minfile $mintemp"
