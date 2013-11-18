#! /bin/bash
#$1: target directory to hipstafy
for img in $(find $1 -name '*.jpg')
do
	prefix=${img%.jpg}
	outputfile=$prefix-hipstah.jpg
	convert -sepia-tone 60% +polaroid $img $outputfile
done
