#!/bin/bash
SCRIPT_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"));
echo $SCRIPT_PATH

# Verify that NeoVim is installed
# If not, then throw an error
if [ ! -x "$(command -v nvim)" ]; then
    echo 'Error: NeoVim is not yet installed.' >&2
    exit 1
fi

# Create hard links for config files
# NOT COPIED: that way changes can easily be saved
TMP_PATH=$HOME/.config/nvim
mkdir -p $TMP_PATH/include
if [ ! -f $TMP_PATH/init.vim ]; then
    ln $SCRIPT_PATH/init.vim $TMP_PATH/init.vim
fi
for f in $SCRIPT_PATH/include/*.vim
do
    newfile=$TMP_PATH/include/$(basename -- $f)
    if [ ! -f "$newfile" ]; then
        echo "Installing NeoVim config file $f to: $newfile"
        ln $f $newfile
    else
        echo "File $newfile was not installed (already exists)."
    fi
done

echo 'Execution finished.'
