# _               _              
#| |__   __ _ ___| |__  _ __ ___ 
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__ 
#|_.__/ \__,_|___/_| |_|_|  \___|

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Infinite history, history file size

HISTSIZE= HISTFILESIZE=

# User specific aliases and functions

alias ll="ls -lrt --color=auto"
alias grep="grep --color=auto"

alias src="source ~/.bashrc"
alias pi="ssh -q brendan@162.222.55.231 -p 2023"
alias showip="echo 162.222.55.231:2185"
alias cdh="cd ~/Desktop/hax"
alias yta="youtube-dl -x --add-metadata"
