# _               _              
#| |__   __ _ ___| |__  _ __ ___ 
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__ 
#|_.__/ \__,_|___/_| |_|_|  \___|

# Source global definitions
[ -f /etc/bashrc ] && [ -r /etc/bashrc ] && source /etc/bashrc

# Load the dotfiles
for FILE in ~/.{aliases,bash_prompt}; do
    [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE";
done
unset FILE

# Infinite history, history file size
HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignoredups
HISTTIMEFORMAT="%d/%m/%y %T "
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
shopt -s histappend
# Fix for st del key
tput smkx

[ -d "$HOME/.bin" ] && PATH="$HOME/.bin:$PATH"

FCEDIT=vim
IP=127.0.0.1
GCPIP=127.0.0.1
[ -f ~/.ip ] && IP=`grep "^IP=[0-9]\+" ~/.ip | cut -d= -f2`
[ -f ~/.ip ] && GCPIP=`grep "^IP_GCP=[0-9]\+" ~/.ip | cut -d= -f2`

# Port variables in case I am local
#PI3PORT=2023
#PI4PORT=2024
PI3PORT=22
PI4PORT=22

# Disable Ctrl-S and Ctrl-Q (freeze and unfreeze) in terminal
[[ $- == *i* ]] && stty -ixon

alias ls="ls --color=auto"
alias sl="ls"
alias ll="ls -lrt"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias rl="readlink -f"
alias fdate='date "+%Y-%m-%d %H:%M"'

alias src="source ~/.bash_profile"
alias vp='vim -S ~/.vim_sessions/profiles.vim'
alias vvrc="vim ~/.vimrc"
alias vrc="vim ~/.bashrc"

alias pi="ssh -p ${PI3PORT} pi@${IP}"
alias pib="ssh -p ${PI3PORT} brendan@${IP}"
alias pi0="ssh -p ${PI4PORT} brendan@${IP}"
alias gcp="ssh brendan_schlaman@${GCPIP}"
alias showip="echo ${IP}:2185"
alias curlip="echo curl ${IP}:2185 && curl ${IP}:2185"
alias curlwebhttp="echo curl ${IP}:443 && curl ${IP}:443"
alias curlweb="echo curl https://www.schlamalama.com && curl https://www.schlamalama.com"
alias bat="cat /sys/class/power_supply/BAT1/capacity"
alias cdb="cd /sys/class/backlight/amdgpu_bl0"
alias yta="youtube-dl -x --audio-format mp3"
alias i3r="i3-msg restart"
alias lock="i3lock -c 000000"
alias num="xset q | grep \"Num Lock\" | awk '{ print \$8 }'"
alias fonts="fc-list | cut -d: -f2 | sort | uniq"
alias wifi="sudo netctl start wlo1-TP-Link_D625"
alias wifihome="sudo netctl start wlo1-MySpectrumWiFi58-2G"
alias sdocker="sudo systemctl start docker"
alias restartx="ps -ef | grep xinit | grep -v grep | awk '{print $2}' | xargs kill"
alias docker="sudo docker"
alias rn="ranger"

alias cdmain="cd ~/main"
alias cdh="cd ~/main/hax"
alias cdlin="cd ~/main/hax/linux_files"
alias cdhtml="cd ~/main/hax/html_files"
alias cdhd="cd ~/main/hax/docker"
alias cds="cd ~/main/hax/scripts/"
alias cdd="cd ~/downloads"
alias cddoc="cd ~/documents"
alias cdpic="cd ~/pictures"
alias cdm="cd ~/music"
alias cdw="cd /etc/netctl"
alias cdpy="cd ~/main/hax/python_files"

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
	FULLPATH=`realpath $1`
	#gsettings set org.gnome.desktop.background picture-uri "file:$FULLPATH"
	feh --bg-scale $FULLPATH
}
function vt(){
    local vcfolder=`ls -d /usr/share/vim/*/colors | egrep 'vim[0-9]+'` && printf '\n'
    ls $vcfolder | cut -d"." -f1 | grep -v README | nl
    read -p "Select desired theme: " ntheme
    local theme=`ls $vcfolder | cut -d"." -f1 | grep -v README | nl | grep -w $ntheme | cut -f2` && sptheme="$theme"
	local cindex=`grep colorscheme ~/.vimrc | grep -ob '"' | cut -d":" -f1`
	for x in `seq 0 $(( cindex - 13 -${#theme} ))` ; do sptheme="$sptheme " ; done
    sed -i "s/colorscheme [a-zA-Z]*[[:space:]]*/colorscheme $sptheme/" ~/.vimrc | grep color && echo Updated vim theme to $theme
}
function wifistop(){
    active=`netctl list | grep \* | sed 's/* \([^\s]\+\)/\1/'`
    if [ ! -z "$active" ] ; then
        echo Stopping $active
        sudo netctl stop $active
    fi
}
function linuxcomp(){
    [ -d ~/main/hax/linux_files/ ] && dir=~/main/hax/linux_files || dir="."
    for x in `find $dir -maxdepth 1 -name ".*" -and -not -type d -printf "%P\n"` ; do
        echo "#### $x ####"
        diff $dir/$x ~/$x
    done
    for x in `find $dir/.config -type f -printf "%P\n"` ; do
        echo "#### $x ####"
        diff $dir/.config/$x ~/.config/$x
    done
}
function transfer(){
    if [ "$1" = "topi" ] && [ $# -gt 1 ] ; then
        shift && eval "scp -rpP ${PI3PORT} $(echo $@ | sed '/\([a-zA-Z]\+ [a-zA-Z]\+\)/s/\(.*\)/{\1}/;s/ /,/g') ${IP}:/transfer"
    elif [ "$1" = "frompi" ] && [ $# -gt 1 ] ; then
        shift && eval "scp -rpP ${PI3PORT} ${IP}:/transfer/$(echo $@ | sed '/\([a-zA-Z]\+ [a-zA-Z]\+\)/s/\(.*\)/{\1}/;s/ /,/g') ."
    else
        echo "ERROR: use either \"topi\" or \"frompi\""
    fi
}
function comptonset(){
    [ -f ~/.config/compton/compton.conf ] && \
    lspci | grep -i virtualbox > /dev/null && \
    echo "You are in a VBox guest. Turning off compton vsync..." && \
    sed -i '/vsync =/s/true/false/' ~/.config/compton/compton.conf \ ||
    echo "You are not in a VBox guest; nothing to do." 
}
function slideshow(){
    [ "$1" = "-r" ] && feh -dz -. -B black || feh -d -. -B black
}
