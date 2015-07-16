#!/bin/bash

for DOTFILE in $(find files -type f)
do
    DOTFILE=${DOTFILE#./}
    ([ -e ~/.$DOTFILE ] || install -D /dev/null ~/.$DOTFILE) &&
        ln -sb $PWD/$DOTFILE ~/.${DOTFILE#files/} &&
        echo "Created link ~/.${DOTFILE#files/} -> $PWD/$DOTFILE"
done
