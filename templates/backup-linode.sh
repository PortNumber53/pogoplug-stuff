#!/bin/bash

#
#  DO NOT EDIT BELOW THIS LINE
#  THIS FILE IS CALLED BY OTHERS
#

# Makes sure we exit if flock fails.
set -e

(
  # Wait for lock on /tmp/.$PROJECTexclusivelock (fd 200) for 10 seconds
  flock -x -w 10 200


  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  source $DIR/../custom/backup-variables.sh

  TODAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "0 day ago"`/$PROJECT
  YESTERDAY_FOLDER=$backup_folder/`date +%Y-%m-%d --date "1 day ago"`/$PROJECT

  if [ ! -d $TODAY_FOLDER ]; then
    mkdir -p $TODAY_FOLDER
    echo "copying..."
    cp -alv $YESTERDAY_FOLDER/. $TODAY_FOLDER
  fi
#  if [ ! -d $TODAY_FOLDER/data ]; then
#    mkdir -p $TODAY_FOLDER/data
#  fi
#  if [ ! -d $TODAY_FOLDER/domains ]; then
#    mkdir -p $TODAY_FOLDER/domains
#  fi

  rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before --exclude=tmp/sess_ --exclude=/dev --exclude=/proc --exclude=/mnt --exclude=/opt --exclude=/sys --exclude=/var/log -laze ssh $PROJECT:/var/www $TODAY_FOLDER/ 1> /tmp/$PROJECT.log 2>&1
#  rsync --bwlimit=$DOWNLOAD_SPEED --force --no-p --progress --delete-before -laze ssh $PROJECT:~/../../domains/ $TODAY_FOLDER/domains 1> /tmp/$PROJECT.log 2>&1

) 200>/tmp/.$PROJECT.exclusivelock

