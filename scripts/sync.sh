#!/bin/sh

SERVER=$1
USER=$(whoami)
LOCAL_DIR=$2
REMOTE_DIR=$3
rsync -rzcltp --progress --delete $LOCAL_DIR $USER@$SERVER:$REMOTE_DIR
