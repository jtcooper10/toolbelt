#!/bin/bash
SCRIPT_PATH=$(dirname $(readlink -f "${BASH_SOURCE[0]}"));
echo $SCRIPT_PATH

# Verify that NeoVim is installed
# If not, then throw an error
if [ ! -x "$(command -v nvim)" ]; then
    echo 'Error: NeoVim is not yet installed.' >&2
    exit 1
fi

# Create soft links for config files
# NOT COPIED: that way changes can easily be saved
TMP_PATH=$HOME/.config/nvim
if [ ! -d "$TMP_PATH" ]; then
    ln -s "$SCRIPT_PATH/include" "$TMP_PATH/include"
    # Link over any root-level config files (.json or .vim)
    ln -s "$SCRIPT_PATH/*.vim" "$TMP_PATH/"
    ln -s "$SCRIPT_PATH/*.json" "$TMP_PATH/"
elif [ ! -f "$TMP_PATH/init.vim" ] || [ ! -f "$TMP_PATH/coc-settings.vim"]; then
    ln -s "$SCRIPT_PATH/init.vim" "$TMP_PATH/init.vim"
    ln -s "$SCRIPT_PATH/coc-settings.vim" "$TMP_PATH/coc-settings.vim"
else
    echo "Configuration already installed"
fi

# Install virtual envs for Python autocomplete
if [ ! -f "$HOME/venvs/jedi/bin/activate" ]; then
    echo "Creating virtual environments for Neovim Python plugins"
    mkdir -p ~/venvs
    python3 -m venv ~/venvs/jedi && source ~/venvs/jedi/bin/activate && python3 -m pip install jedi && deactivate
    python3 -m venv ~/venvs/neovim && source ~/venvs/neovim/bin/activate && python3 -m pip install neovim && deactivate
    python3 -m venv ~/venvs/black && source ~/venvs/black/bin/activate && python3 -m pip install black && deactivate
    python3 -m venv ~/venvs/pylint && source ~/venvs/pylint/bin/activate && python3 -m pip install pylint && deactivate
    echo "Python venvs created"
fi

echo 'Execution finished.'
