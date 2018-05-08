# -*- mode: shell-script -*-
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
    fi
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
	echo "sourcing rvm"
	source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi
