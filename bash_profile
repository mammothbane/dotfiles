# -*- mode: shell-script -*-
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f "$HOME/.local_bash_profile" ]; then
	source "$HOME/.local_bash_profile"
fi
