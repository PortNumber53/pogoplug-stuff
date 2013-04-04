#!/bin/bash

#
#  DO NOT EDIT BELOW THIS LINE
#  THIS FILE IS CALLED BY OTHERS
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../custom/backup-variables.sh

pid=/tmp/$PROJECT.pid
TODAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "0 day ago"`/$PROJECT
YESTERDAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "1 day ago"`/$PROJECT

if [ -e $pid ]
then
	echo "$PROJECT Still running..."
else
	touch $pid

	if [ ! -d $TODAY_FOLDER ]; then
		mkdir -p $TODAY_FOLDER
		echo "copying..."
		cp -alv $YESTERDAY_FOLDER/. $TODAY_FOLDER
	fi
	if [ ! -d $TODAY_FOLDER/data ]; then
		mkdir -p $TODAY_FOLDER/data
	fi
	if [ ! -d $TODAY_FOLDER/domains ]; then
		mkdir -p $TODAY_FOLDER/domains
	fi

	rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before --exclude=tmp/sess_ --laze ssh $PROJECT:~/../../data/ $TODAY_FOLDER/data 1> /tmp/$PROJECT.log 2>&1
	rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before -laze ssh $PROJECT:~/../../domains/ $TODAY_FOLDER/domains 1> /tmp/$PROJECT.log 2>&1

	rm $pid
fi

