#!/bin/bash
MASTER_USER=httpd

sleep 30
RUNNING=`ps ax| grep 60000 | grep -v grep | wc -l`

if [ "$RUNNING" -lt 1 ]; then

node_data="\{\"ip_for\":\"live\"\}"
MASTER_IP_ADDRESS=`curl --header "node:$NODE" \
     --header "hash:$HASH" \
     "http://portnumber53.com/monitor/network/node?request=$node_data" | \
  jshon -e ip_address | \
  sed "s/^\([\"']\)\(.*\)\1\$/\2/g"`

MASTER_SSH_PORT=18022
NODE_PORT=60000

echo "Opening ssh tunnel" >> /tmp/ssh_tunnel.log
ssh -t -t -R $NODE_PORT:localhost:22 $MASTER_USER@$MASTER_IP_ADDRESS -p $MASTER_SSH_PORT &

fi
echo "End " >> /tmp/ssh_tunnel.log
