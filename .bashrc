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
HISTSIZE= HISTFILESIZE=

# Disable Ctrl-S and Ctrl-Q (freeze and unfreeze) in terminal
stty -ixon

alias sl="ls"
alias ll="ls -lrt --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

alias src="source ~/.bash_profile"
alias vp='vim -S ~/.vim_sessions/profiles.vim'
alias vvrc="vim ~/.vimrc"
alias vbrc="vim ~/.bashrc"

alias pi="ssh -q brendan@162.222.55.231 -p 2023"
alias showip="echo 162.222.55.231:2185"
alias yta="youtube-dl -x --audio-format mp3"
alias rn="ranger"

alias cdh="cd ~/Desktop/hax"
alias cdd="cd ~/Downloads"
alias cddoc="cd ~/Documents"
alias cdpic="cd ~/Pictures"
alias cdm="cd ~/Music"
alias cdphone="cd /run/user/*/gvfs/mtp*/Phone"

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
function vt(){
    local vcfolder=`ls -d /usr/share/vim/*/colors | egrep 'vim[0-9]+'` && printf '\n'
    ls $vcfolder | cut -d"." -f1 | grep -v README | nl
    read -p "Select desired theme: " ntheme
    local theme=`ls $vcfolder | cut -d"." -f1 | grep -v README | nl | grep -w $ntheme | cut -f2` && sptheme="$theme"
	local cindex=`grep colorscheme ~/.vimrc | grep -ob '"' | cut -d":" -f1`
	for x in `seq 0 $(( cindex - 13 -${#theme} ))` ; do sptheme="$sptheme " ; done
    sed -i "s/colorscheme [a-zA-Z]*[[:space:]]*/colorscheme $sptheme/" ~/.vimrc | grep color #&& echo Updated vim theme to $theme
}
