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

set -o vi

alias ll="ls -lrt --color=auto"
alias sl="ls"
alias grep="grep --color=auto"

alias src="source ~/.bashrc"
alias pi="ssh -q brendan@162.222.55.231 -p 2023"
alias showip="echo 162.222.55.231:2185"
alias cdh="cd ~/Desktop/hax"
alias yta="youtube-dl -x --audio-format mp3"
alias rn="ranger"

alias cdd="cd ~/Downloads"
alias cddoc="cd ~/Documents"
alias cdpic="cd ~/Pictures"
alias cdvid="cd ~/Videos"
alias cdm="cd ~/Music"

# Outputs a number between 0 and $1 ; 10 by default
function rand(){
	def=10
	[ $# -gt 0 ] && ! [ $1 -lt 1 ] && def=$1 || return
	echo $(( RANDOM % def ))
	# Also valid shell randomizer:
	# shuf -i 0-$def -n 1
}
function setwall(){
	[ $# -ne 1 ] && return
	FULLPATH=`realpath $1` && gsettings set org.gnome.desktop.background picture-uri "file:$FULLPATH"
}
