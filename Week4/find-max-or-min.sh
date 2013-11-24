#! /bin/bash

unset csv
unset program
unset dirname
print_help() {
  echo "\
Usage: `basename $0` [-t] -c | -w -p dir
Arguments:
  -t        output as tab-separated values
  -c        find the coldest temperature
  -w        find the warmest temperature
  -p dir    search all subdirs of dir"
}

coldest=false 
warmest=false
tab=false

while getopts ":htcwp:" opt; do

	case $opt in
		t)
			tab=true
			;;
		c)
			coldest=true
			;;
		w)
			warmest=true
			;;
		p)
			dir=$OPTARG
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			print_help
			exit 1
			;;	
	esac
done

if $coldest && $warmest; then
	echo "Cannot combine options -c and -w" >&2
	print_help
	exit 1
elif (! $coldest) && (! $warmest); then
	echo "Missing option -c or -w" >&2
	print_help
	exit 1
elif $warmest; then
	main="./daily-hottest.sh"
else
	main="./daily-coldest.sh"
fi

if  ! [ -n "$dir" ]; then
	echo "Missing option -p or missing parameter for option -p" >&2
	print_help
	exit 1
else
	main="$main $dir"
fi

if $tab; then
	main="$main | ./in-tsv-format.sh" 
fi

eval $main