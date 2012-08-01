#!/bin/bash

internal_ip=`hostname -i|sed -e 's/  *$//'`
node_data="\{internal_ip:$internal_ip\}"

curl --header "node:$node" \
     --header "hash:$hash" \
     "http://portnumber53.com/monitor/network/poke?request=$node_data" 1> /tmp/poke.log 2>&1
