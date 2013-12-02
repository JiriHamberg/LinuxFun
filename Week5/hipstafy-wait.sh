#!/bin/sh
#$1: folder to watch for

#set inotifywait to watch folder $1
inotifywait -mr --format '%e %f %w' $1 | \
while read EVENT FILE FOLDER; do
	#check if event was "MOVED_TO" and file has .jpg extension
	if [ $EVENT = "MOVED_TO" ] && $(echo "$FILE" | grep -q '.*\.jpg'); then
		./hipstafy-one.sh "$FOLDER$FILE"
	fi
done