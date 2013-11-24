#! /bin/bash
maxtemp=-100
maxfile=""


for folder in $*
do
	for file in $(find $folder -name '*temps.txt')
	do
		#extract current files processor zone temp
		temp=$( grep "PROCESSOR_ZONE" < $file | sed 's/\ \+/ /g' | cut -d ' ' -f3 | cut -d "C" -f1 )
		if [ $temp -gt $maxtemp ]; then
			maxtemp=$temp
			maxfile=$file
		fi
	done
done
echo "$maxfile $maxtemp"
