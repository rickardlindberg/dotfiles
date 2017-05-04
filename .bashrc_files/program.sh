shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file syn
# if this is interactive shell, then bind rlselect to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a rlselect-history \C-j"'; fi
if [[ $- =~ .*i.* ]]; then bind '"\C-t": "\C-a rlselect-and-run \C-j"'; fi
