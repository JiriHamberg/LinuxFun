#! /bin/bash
#$1: target file to hipstafy
prefix=${1%.jpg}
outputfile=$prefix-hipstah.jpg
convert -sepia-tone 60% +polaroid $1 $outputfile
