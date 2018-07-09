#!/usr/bin/env bash

if ! type -P realpath ; then
	realpath() {
		[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
	}
fi


odir=$HOME
script_path=$(realpath $0)
script_dir=$(dirname $script_path)
oldDir=$HOME/.old

set -e

case "$(uname -s)" in
	Linux*)
		sudo apt update
		sudo apt install -yqq python3-dev python3-pip zsh
		;;
	Darwin*)
		if ! type -P brew ; then
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi

		brew install ruby python
		brew link --overwrite ruby

		;;
esac

# Install oh-my-zsh
if [ ! -d $HOME/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo installing fuck
pip3 install --user thefuck

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
