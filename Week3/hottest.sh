#! /bin/bash
maxtemp=-100
maxfile=""

for file in $(find lost24/monitor/2011.11.* -name '*temps.txt')
do
	#extract current files processor zone temp
	temp=$( grep "PROCESSOR_ZONE" < $file | sed 's/\ \+/ /g' | cut -d ' ' -f3 | cut -d "C" -f1 )
	if [ $temp -gt $maxtemp ]; then
		maxtemp=$temp
		maxfile=$file
	fi
done
echo "Highest temperature was $maxtemp in file $maxfile"