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
	echo "Still running..."
else
	touch $pid

	if [ ! -d $TODAY_FOLDER ]; then
		mkdir -p $TODAY_FOLDER
		#echo "copying..."
		#cp -alv $YESTERDAY_FOLDER/. $TODAY_FOLDER
	fi

	cd $TODAY_FOLDER
	wget --output-file=/tmp/$PROJECT.log --tries=3 --passive-ftp --mirror --ftp-user=$USER --ftp-password=$PASSWORD ftp://$SERVER

	rm $pid
fi
