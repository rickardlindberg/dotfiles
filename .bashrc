if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bashrc_files/local.sh ]; then
    . ~/.bashrc_files/local.sh
fi

. ~/.bashrc_files/env.sh
. ~/.bashrc_files/program.sh
. ~/.bashrc_files/aliases.sh
. ~/.bashrc_files/hg.sh
. ~/.bashrc_files/prompt.sh
. ~/.bashrc_files/vcs.sh
