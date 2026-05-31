#!/bin/bash

FILEPATH="/"
THRESHOLD=80
VERBOSE=false

while getopts "p:t:vh" OPTION
do 
	case "$OPTION" in
		p) 
			FILEPATH="$OPTARG"
			;;
		t) 
			
			THRESHOLD="$OPTARG"
			;;

		v)
			VERBOSE=true
			;;
		h) 
			echo help page
			echo "p = Path, t = Threshold (default = 80), v = verbose"
			exit 0
			;;
	esac
done

if [ ! -e "$FILEPATH" ]; then echo FILE PATH does not exist; exit 1; fi

if $VERBOSE
then
    echo "Checking path: $FILEPATH"
    echo "Threshold: $THRESHOLD%"
fi

WARNING=$(df -h "$FILEPATH" | awk -v thresh="$THRESHOLD" 'NR==2 && $5+0 >= thresh { print $5 }')

if [ -n "$WARNING" ]
then
	echo WARNING THRESHOLD BREACHED
	echo "$WARNING"
else
	echo ALL OK
fi
