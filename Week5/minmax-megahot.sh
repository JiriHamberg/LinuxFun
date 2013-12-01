#! /bin/bash
maxtemp=-100
mintemp=100
maxfile=""
minfile=""

#cut -d ' ' -f3 | cut -d "C" -f1 |

find $1 -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + |  \
sed 's/\ \+/ /g;s/:#1 PROCESSOR_ZONE / /;s/\([0-9]\+\)C\/[0-9]\+F.*F/\1/' | \
 while read file temp; do
 	if [ $temp -lt $mintemp ]; then
 		mintemp=$temp
 		minfile=$file
 		echo "NEW MIN: $minfile $mintemp"
 	fi
 	if [ $temp -gt $maxtemp ]; then
 		maxtemp=$temp
 		maxfile=$file
 		echo "NEW MAX: $maxfile $maxtemp"
 	fi
 done
