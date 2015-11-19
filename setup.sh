#!/usr/bin/env bash

odir=$HOME
script_path=$(realpath $0)
script_dir=$(dirname $script_path)

set -e

for file in $script_dir/*; do
    # don't copy this script over
    if [[ $file == $script_path ]]; then
	continue
    fi

    dest=$odir/.$(basename $file)
        
    if [ -e $dest ]; then
	if [ -L $dest ]; then
	    rm $dest
	else
	    if [ ! -n $oldDir ]; then
		oldDir=$HOME/.old
	    fi

	    mv $dest $oldDir/$(basename $dest)
	fi
    fi

    ln -sf $file $odir/.$(basename $file)
done

# Install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

