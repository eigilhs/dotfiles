#!/bin/sh

SCRIPTDIR=$(cd "$(dirname "$0")" && pwd)

for dotfile in $(find "$SCRIPTDIR/files" -type f)
do
    target=~/.${dotfile##*files/}
    [ ! -e $target ] &&
	mkdir -p $(dirname $target) &&
        ln -s $dotfile $target &&
        echo "Created link $target -> $dotfile" || echo "$target already exists"
done
