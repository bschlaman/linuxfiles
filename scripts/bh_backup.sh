#!/bin/sh

# Crontab:
# 0 2 * * * /home/brendan/.bin/bh_backup.sh
# @reboot /home/brendan/.bin/bh_backup.sh

[ -d $HOME/.bkp_bash_history ] || mkdir -v $HOME/.bkp_bash_history

TS=`date "+%Y-%m-%d_%H%M"`
FPATH=$HOME/.bkp_bash_history/${TS}_bash_history

[ -f $FPATH ] || cp $HOME/.bash_history $FPATH
