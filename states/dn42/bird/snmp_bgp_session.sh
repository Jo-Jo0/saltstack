#!/bin/bash

# CONTROLLED BY SALTSTACK!
#
# monitors BGP session status.
# needs sudo access to birdc/birdc6 binaries!

BIRDC="/usr/sbin/birdc"
BIRDC6="/usr/sbin/birdc6"

if [ $1 -eq 4 ]; then
	CMD=$BIRDC
else
	CMD=$BIRDC6
fi

sudo $CMD show protocols |awk '$1 ~ /'$2'/ { print $6 }'

