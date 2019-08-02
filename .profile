if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] && [ -r "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
