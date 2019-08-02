if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] && [ -r "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi

	# Source global definitions
	if [ -f /etc/bashrc ] && [ -r /etc/bashrc ]; then
		. /etc/bashrc
	fi
fi
