# _               _              
#| |__   __ _ ___| |__  _ __ ___ 
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__ 
#|_.__/ \__,_|___/_| |_|_|  \___|

# Load the dotfiles
for FILE in ~/.{aliases,bash_prompt,bash_completion}; do
    [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE";
done ; unset FILE

# Infinite history, history file size
HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignoredups
HISTTIMEFORMAT="%d/%m/%y %T "
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
shopt -s histappend

# disable Ctrl-S and Ctrl-Q (freeze and unfreeze) in terminal
[[ $- == *i* ]] && stty -ixon
# fix for st del key
tput smkx
