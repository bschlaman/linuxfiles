#!/bin/bash

UNAME=$1
PASS=$2
DOMAIN=$3
LOGFILE=hist.log

echo [ $(date "+%Y-%m-%d %H:%M") ] | tee -a $LOGFILE
curl -sS https://$UNAME:$PASS@domains.google.com/nic/update?hostname=$DOMAIN | tee -a $LOGFILE \
	&& echo -e "\nSuccessfully updated [ $DOMAIN ]" | tee -a $LOGFILE

