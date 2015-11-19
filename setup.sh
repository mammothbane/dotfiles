#!/usr/bin/env bash

ODIR=$HOME

set -e

for file in $PWD/*; do
    #echo considering $file
    if [[ $file == $(realpath $0) ]]; then
	continue
    fi

    DEST=$ODIR/.$(basename $file)
    
    if [ -d $DEST ]; then
	if [ -L $DEST ]; then
	    rm $DEST
	    ln -sf $file $ODIR/.$(basename $file)
	else
	    echo "Error: directory $file exists and isn't a symlink."
	    exit 1
	fi
    else
	ln -sf  $file $ODIR/.$(basename $file)
    fi

    #echo linking $file to $ODIR/.$(basename $file)
    
done
