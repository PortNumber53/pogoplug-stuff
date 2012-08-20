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
	echo "Still running..."
else
	touch $pid

	if [ ! -d $TODAY_FOLDER ]; then
		mkdir -p $TODAY_FOLDER
		#echo "copying..."
		#cp -alv $YESTERDAY_FOLDER/. $TODAY_FOLDER
	fi

	cd $TODAY_FOLDER
	wget --output-file=$project.log --tries=3 --passive-ftp --mirror --ftp-user=$user --ftp-password=$password ftp://$server

	rm $pid
fi
