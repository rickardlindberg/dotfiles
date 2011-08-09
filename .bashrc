if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bashrc_files/local.sh ]; then
    . ~/.bashrc_files/local.sh
fi

. ~/.bashrc_files/hg.sh
. ~/.bashrc_files/diff.sh
. ~/.bashrc_files/prompt.sh
