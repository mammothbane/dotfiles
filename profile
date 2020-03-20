# -*- mode: shell-script -*-

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    	source "$HOME/.bashrc"
    fi
else
    source "$HOME/.rc"
fi
