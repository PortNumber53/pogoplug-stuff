#!/bin/bash

############STOP EDITING HERE
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/templates/poke_monitor.sh 1> /tmp/poke.log 2>&1
