#!/bin/bash

# TODO: Pull from a list of config folders rather than hard-coding them

# Add any new config locations to the functions below
function backupcfg {
    cp -r ~/.config/nvim ./backup/nvim
}
function clearcfg {
    rm -rf ~/.config/nvim
}

# Prompt the user if they want a backup or not, only accepts Y/N
while [ -z $BACKUP ]; do
    printf "Do you want to create a backup copy of your configration files? (Y/N): "
    read -n1 BACKUP
    echo
    BACKUP=${BACKUP^^}
    if [ $BACKUP != "Y" ] && [ $BACKUP != "N" ]; then
        echo "Unrecognized response: $BACKUP"
        unset BACKUP
    fi
done

# If a backup was requested, create a ./backup/ folder and copy all files over
if [ $BACKUP == "Y" ]; then
    mkdir -p ./backup
    backupcfg && clearcfg
elif [ $BACKUP == "N" ]; then
    clearcfg
fi

