# _               _              
#| |__   __ _ ___| |__  _ __ ___ 
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__ 
#|_.__/ \__,_|___/_| |_|_|  \___|

# Load the dotfiles
for FILE in ~/.{aliases,bash_prompt,bash_completion,work_aliases}; do
    [ -r "$FILE" ] && [ -f "$FILE" ] && source "$FILE";
done ; unset FILE

# Infinite history, history file size, no truncation
HISTSIZE=-1
HISTFILESIZE=-1
# disable suppression of e.g. duplicates, leading space cmds, etc
unset HISTCONTROL
# no ignored cmds
unset HISTIGNORE
# HISTTIMEFORMAT controls formatting for `history` cmd outputs
HISTTIMEFORMAT="%F %T "

# PROMPT_COMMAND
#   - history -a: Write each command to ~/.bash_history immediately after it finishes.
#   - history -n: Read commands newly written by other shells
# ----------------------------------------------------
# Newer versions of bash: PROMPT_COMMAND is an array
# However, some of my servers either have old versions or something else makes it a string,
# so I need to support both
if [[ $(declare -p PROMPT_COMMAND 2>/dev/null) == "declare -a"* ]]; then
    PROMPT_COMMAND=('history -a' 'history -n' "${PROMPT_COMMAND[@]}")
else
    PROMPT_COMMAND="history -a;history -n${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi

# save multi-line commands as a single history entry (with semicolons)
shopt -s cmdhist
# when cmdhist enabled, preserve newlines in multi-line commands (no semicolons)
shopt -s lithist
# Append rather than overwrite history
shopt -s histappend

# disable Ctrl-S and Ctrl-Q (freeze and unfreeze) in terminal
[[ $- == *i* ]] && stty -ixon
# fix for st del key
[[ $- == *i* ]] && tput smkx
