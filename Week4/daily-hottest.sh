#! /bin/bash
#give lost24 folder as param1
find $1 -type d -regextype sed -regex '.*\/[0-9]\{4\}\.[0-9]\+\.[0-9]\+' | sort | while read day
do
	./hottest-by-folder.sh $day
done