#!/bin/bash

COUNT=`/usr/bin/find $FILTER -maxdepth 0 -type d -mtime +$DAYS | /usr/bin/wc -l`
MINDIRS=$mininum

if [[ $COUNT -gt $MINDIRS ]]
        then
		/usr/bin/find $FILTER -maxdepth 0 -type d -mtime +$DAYS
		#exit
		for i in `/usr/bin/find $FILTER -maxdepth 0 -type d -mtime +$DAYS`; do
			echo -e "Deleting $i";
			rm -rfv $i;
		done
	else
		echo "NOT ENOUGH ITEMS"
fi
