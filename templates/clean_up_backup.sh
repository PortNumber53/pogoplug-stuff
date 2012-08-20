#!/bin/bash

COUNT=`/usr/bin/find $filter -maxdepth 0 -type d -mtime +$days | /usr/bin/wc -l`
MINDIRS=$mininum

if [[ $COUNT -gt $MINDIRS ]]
        then
		/usr/bin/find $filter -maxdepth 0 -type d -mtime +$days
		#exit
		for i in `/usr/bin/find $filter -maxdepth 0 -type d -mtime +$days`; do
			echo -e "Deleting $i";
			rm -rfv $i;
		done
	else
		echo "NOT ENOUGH ITEMS"
fi
