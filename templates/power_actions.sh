#!/bin/bash
FILE=$1

(
  flock -e 200
	echo "Checking for power action:"

	if [ -f $FILE ];
	then
		echo "File $FILE exists."
		rm $FILE
		sync
		sync
		/sbin/poweroff
	fi


) 200>/tmp/blah.lockfile
echo "End of script"
