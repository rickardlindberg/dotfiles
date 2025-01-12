if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/projects/dotfiles/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/projects/dotfiles/bin:$PATH"
fi
export PATH

export EDITOR=vim

shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file syn

rlselect-history() {
    local action
    local selection
    {
        read action
        read selection
    } < <(tac ~/.bash_history | rlselect --tab --action -- "${READLINE_LINE}")
    if [ "$action" = "tab" ]; then
        READLINE_LINE="${selection}"
        READLINE_POINT=${#READLINE_LINE}
        bind '"\C-x2":' # Bind Ctrl+x+2 to do nothing
    elif [ "$action" = "enter" ]; then
        READLINE_LINE="${selection}"
        READLINE_POINT=${#READLINE_LINE}
        bind '"\C-x2": accept-line' # Bind Ctrl+x+2 to accept line
    else
        bind '"\C-x2":' # Bind Ctrl+x+2 to do nothing
    fi
}
if [[ $- =~ .*i.* ]]; then
    # Bind history commands to Ctrl+x+1 followed by Ctrl+x+2:
    bind '"\C-r": "\C-x1\C-x2"'
    bind '"\C-n": "\C-x1\C-x2"'
    bind '"\C-p": "\C-x1\C-x2"'
    bind '"\e[A": "\C-x1\C-x2"' # up-arrow
    bind '"\e[B": "\C-x1\C-x2"' # down-arrow
    # Bind Ctrl+x+1 to execute rlselect-history which does two things:
    # 1. Sets READLINE_*
    # 2. Binds Ctrl+x+2 to either accept line or do nothing.
    bind -x '"\C-x1": rlselect-history'
fi

rlselect-go() {
    local selection
    if [ "$1" = "" ]; then
        selection="$(find-dirs ~ 3 | rlselect)"
    else
        selection="$(find-dirs "$1" | rlselect)"
    fi
    if [ $? = 0 ]; then
        cd "$selection"
    fi
}

alias g=rlselect-go
