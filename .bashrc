# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export EDITOR='nvim'

# Deno environment variables
export DENO_INSTALL="/home/josh/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

# Node/NPM environment variables
export NODE_PATH="~/.nvm/versions/$(node --version)/lib/node_modules"

# Use Powerline
# export XDG_CONFIG_HOME="$HOME/.config"
# export TERM="screen-256color"
# if [ -f `which powerline-daemon` ]; then
#	powerline-daemon -q
#	POWERLINE_BASH_CONTINUATION=1
#	POWERLINE_BASH_SELECT=1
#	. /usr/share/powerline/bash/powerline.sh
# fi

# Customize prompt
function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
function parse_errno {
    local BASE_COLOR
    if [ ${1} -eq "0" ]; then
        BASE_COLOR="41"
    else
        BASE_COLOR="160"
    fi
    echo $BASE_COLOR
}
function errno_example {
    echo $?
}
# For both of these functions, the 1st argument is the 0-255 color code
function __custom_prompt_command {
    local ERRNO_TMP=$?
    __ERRNO_BASH_STORAGE=$(printf "%03d\n" $ERRNO_TMP)
}
PROMPT_COMMAND=__custom_prompt_command
function ps1_create_color {
    echo "\e[38;5;${1}m"
}
function ps1_create_bold {
    echo "\e[1m`ps1_create_color ${1}`"
}
function init_ps1 {
    local CLEAR="\[\e[00m\]"

    local PROMPT_CHAR="☃️ "
    local USERNAME="\[`ps1_create_bold 39`\]\u${CLEAR}"
    local HOSTNAME="\[`ps1_create_color 30`\]\h${CLEAR}"
    local LOCATION="\[`ps1_create_bold 123`\] ~(\W) ${CLEAR}"
    local ERRNO="\[`ps1_create_color '\$(parse_errno \${__ERRNO_BASH_STORAGE})'`\][\${__ERRNO_BASH_STORAGE}]${CLEAR}"
    # local ERRNO="`ps1_create_color $(parse_errno)`(\$?)${CLEAR}"
    local GIT="\[`ps1_create_color 223`\]\$(parse_git_branch)${CLEAR}"
    local PROMPT="\[`ps1_create_bold 87`\] ${PROMPT_CHAR} ${CLEAR}"
    export PS1="${USERNAME}@${HOSTNAME} :: ${LOCATION}${GIT} \n ${ERRNO}${PROMPT}"
}
init_ps1

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
