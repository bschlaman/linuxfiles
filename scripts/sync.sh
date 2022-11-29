#!/bin/sh

SERVER=$1
USER=$(whoami)
LOCAL_DIR=$2
REMOTE_DIR=$3
rsync -rzcltpN --progress --delete $LOCAL_DIR $USER@$SERVER:$REMOTE_DIR

# rsync -ac --progress $LOCAL_DIR $USER@$SERVER:$REMOTE_DIR

# -c skip based on cksum, not mod-time & size
# -l copy symlinks as symlinks
# -p preserve permissions
# -t preserve timestamps
# -N preserve create times (newness)
