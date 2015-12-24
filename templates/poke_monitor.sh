#!/bin/bash

internal_ip=`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'`
node_data="\{\"internal_ip\":\"$internal_ip\"\}"

curl --header "node:$NODE" \
     --header "hash:$HASH" \
     "http://portnumber53.com/monitor/network/poke?request=$node_data" 1> /tmp/poke.log 2>&1
