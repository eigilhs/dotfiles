#!/bin/bash

for DOTFILE in $(find . -type f)
do
    DOTFILE=${DOTFILE#./}
    [ $DOTFILE != `basename $0` ] &&
        ([ -e ~/.$DOTFILE ] || install -D /dev/null ~/.$DOTFILE) &&
        ln -sb $PWD/$DOTFILE ~/.$DOTFILE &&
        echo "Created link ~/.$DOTFILE -> $PWD/$DOTFILE"
done
