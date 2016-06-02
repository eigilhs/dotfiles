#!/bin/bash

rm -f files/*~
for DOTFILE in $(find files -type f)
do
    ([ -e ~/.${DOTFILE#files/} ] || install -D /dev/null ~/.${DOTFILE#files/}) &&
        ln -sb $PWD/$DOTFILE ~/.${DOTFILE#files/} &&
        echo "Created link ~/.${DOTFILE#files/} -> $PWD/$DOTFILE"
done
