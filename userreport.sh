#!/bin/bash

SHOWUSER=""
SHOWALL=false
SHOWSHELL=false

while getopts "u:ash" OPTION
do
	case "$OPTION" in
		u)
			SHOWUSER="$OPTARG"
			;;
		a) 
			SHOWALL=true
			;;
		s) 	
			SHOWSHELL=true
			;;
		h)
			echo HELP SECTION
			exit 0
			;;
	esac
done

if [ -n "$SHOWUSER" ] && [ "$SHOWALL" = true ]
then
	echo "CANNOT use option -u and -a together"
	echo EXITING
	exit 1
fi

if [ -z "$SHOWUSER" ] && [ "$SHOWALL" = false ]
then
	echo "Enter either option -u or -a"
	echo EXITING
	exit 1
fi

if [ -n "$SHOWUSER" ] && [ "$SHOWSHELL" = true ]
then
	SHELLREPORT=$( cat /etc/passwd | awk -F: -v user="$SHOWUSER" '$1==user { print $NF}')
	if [ -z "$SHELLREPORT" ]; then echo user does not exist; exit 1; fi
	echo "$SHELLREPORT"
	exit 0
fi

if [ -n "$SHOWUSER" ] 
then
	USERREPORT=$( cat /etc/passwd | awk -F: -v user="$SHOWUSER" '$1==user { print }' )
	if [ -z "$USERREPORT" ]; then echo user does not exist; exit 1; fi
	echo "$USERREPORT" | awk -F: '
	{
	print "User: " $1
    	print "UID: " $3
    	print "GID: " $4
    	print "Home: " $6
    	print "Shell: " $7
	}'
fi

if [ "$SHOWALL" = true ]; then cat /etc/passwd | awk -F: '$3 >= 1000{ print $1 }'; fi

