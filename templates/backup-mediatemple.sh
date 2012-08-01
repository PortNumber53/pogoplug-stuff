#!/bin/bash

#
#  DO NOT EDIT BELOW THIS LINE
#  THIS FILE IS CALLED BY OTHERS
#

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/../custom/backup-variables.sh

pid=/tmp/$project.pid
TODAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "0 day ago"`/$project
YESTERDAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "1 day ago"`/$project

if [ -e $pid ]
then
	echo "$project Still running..."
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

	rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before -laze ssh $project:~/../../data/ $TODAY_FOLDER/data
	rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before -laze ssh $project:~/../../domains/ $TODAY_FOLDER/domains

	rm $pid
fi

