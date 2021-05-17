[ -f "$HOME/.profile" ] && [ -r "$HOME/.profile" ] && source "$HOME/.profile"

# vi movements in terminal after <ESC> (Can't do with shell!)
# set -o vi

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] ; then
	exec startx
fi
