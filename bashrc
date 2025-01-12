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
    elif [ "$action" = "enter" ]; then
        # TODO: how to execute this command?
        READLINE_LINE="${selection}"
        READLINE_POINT=${#READLINE_LINE}
    fi
}
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": rlselect-history'; fi

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
