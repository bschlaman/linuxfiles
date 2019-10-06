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

# Disable Ctrl-S and Ctrl-Q (freeze and unfreeze) in terminal
stty -ixon

alias ls="ls --color=auto"
alias sl="ls"
alias ll="ls -lrt"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias rl="readlink -f"

alias src="source ~/.bash_profile"
alias vp='vim -S ~/.vim_sessions/profiles.vim'
alias vvrc="vim ~/.vimrc"
alias vbrc="vim ~/.bashrc"

alias pi="ssh -qp 2023 pi@162.222.55.231"
alias pib="ssh -qp 2023 brendan@162.222.55.231"
alias showip="echo 162.222.55.231:2185"
alias curlip="echo curl 162.222.55.231:2185 && curl 162.222.55.231:2185"
alias curlwebhttp="echo curl 162.222.55.231:443 && curl 162.222.55.231:443"
alias curlweb="echo curl https://www.schlamalama.com && curl https://www.schlamalama.com"
alias bat="cat /sys/class/power_supply/BAT1/capacity"
alias cdb="cd /sys/class/backlight/amdgpu_bl0"
alias yta="youtube-dl -x --audio-format mp3"
alias i3r="i3-msg restart"
alias lock="i3lock -c 000000"
alias wifi="sudo netctl start wlo1-NETGEAR04"
alias rn="ranger"

alias cdmain="cd ~/main"
alias cdh="cd ~/main/hax"
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
    sed -i "s/colorscheme [a-zA-Z]*[[:space:]]*/colorscheme $sptheme/" ~/.vimrc | grep color #&& echo Updated vim theme to $theme
}
function wifistop(){
    for x in /etc/netctl/wlo1-* ; do
    echo Stopping $x
    sudo netctl stop `basename $x`
    done
}
function linuxcomp(){
    for x in `find . -maxdepth 1 -name ".*" -and -not -type d` ; do
    echo "#### $x ####"
    diff ~/main/hax/linux_files/$x ~/$x
    done
}
function transfer(){
    if [ "$1" = "topi" ] ; then
    scp -rP 2023 $2 162.222.55.231:/transfer
    elif [ "$1" = "frompi" ] ; then
    scp -rP 2023 162.222.55.231:/transfer/$2 .
    fi
}
