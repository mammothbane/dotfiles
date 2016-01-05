#!/usr/bin/env bash

odir=$HOME
script_path=$(realpath $0)
script_dir=$(dirname $script_path)
oldDir=$HOME/.old

set -e

# Install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f /usr/local/bin/thefuck ]; then
    echo installing fuck
    wget -O - https://raw.githubusercontent.com/nvbn/thefuck/master/install.sh | sh - && $0
fi

mkdir -p $oldDir # create a directory to house the old contents of the home directory

for file in $script_dir/*; do
    # don't copy this script over
    if [[ $file == $script_path ]]; then
	continue
    fi

    dest=$odir/.$(basename $file)

    # if the file exists and is a symlink, remove it so we can re-link it
    if [ -e $dest ]; then
	if [ -L $dest ]; then
	    rm $dest
	else # otherwise, move the old file into the .old directory with a timestamp
	    mv $dest $oldDir/$(basename $dest)-$(date +%s)
	fi
    fi

    # link the file where it should be 
    ln -sf $file $dest
done
