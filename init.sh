#!/bin/bash

# Run install sub-scripts
# Install NeoVim configurations
# cd conf/nvim
#conf/nvim/install.sh

# Copy bash profile stuff
if [ -f "$HOME/.bashrc" ]; then
    echo ".bashrc already exists, creating backup at $HOME/.bashrc.bk"
    cp $HOME/.bashrc $HOME/.bashrc.bk
    rm $HOME/.bashrc
fi
ln .bashrc $HOME/.bashrc
