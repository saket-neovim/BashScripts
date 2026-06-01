#!/bin/bash

SOURCE_PATH=""
DEST_PATH=""
COMPRESS_CHECK=false
DRY_RUN_CHECK=false

while getopts "s:d:cnh" OPTION
do 
	case "$OPTION" in 
		s)
			SOURCE_PATH="$OPTARG"
			;;
		d)
			DEST_PATH="$OPTARG"
			;;
		c)	
			COMPRESS_CHECK=true
			;;
		n)
			DRY_RUN_CHECK=true
			;;
		h)
			echo HELP SECTION
			echo ------------
			exit 0
			;;
	esac
done

if [ -z "$SOURCE_PATH" ] || [ -z "$DEST_PATH" ]
then
	echo Source and Dest path need to be entered
	exit 1
fi

if [ ! -f "$SOURCE_PATH" ]
then
	echo Source path does not exist
	exit 1
fi

if [ ! -d "$DEST_PATH" ]
then
	echo Dest Path does not exist
	exit 1
fi

TIMESTAMP=$( date +%F)
FILENAME=$( basename "$SOURCE_PATH")
BACKUP="$DEST_PATH/$FILENAME.$TIMESTAMP.bak"

if [ "$DRY_RUN_CHECK" = true  ]
then
	if [ "$COMPRESS_CHECK" = true ]
	then
		echo Would copy "$SOURCE_PATH" to "$BACKUP" and compress it
	else
		echo Would copy "$SOURCE_PATH" to "$BACKUP"
	fi
	exit 0
fi

cp "$SOURCE_PATH" "$BACKUP"

if [ "$COMPRESS_CHECK" = true ]
then
	gzip "$BACKUP"
	BACKUP="${BACKUP}.gz"
fi

	
	       

