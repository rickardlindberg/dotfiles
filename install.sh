#!/bin/sh

install_dotfiles() {
    cd $(dirname "$0")
    list_active_dotfiles | clean_up
    list_inactive_dotfiles | clean_up
    list_active_dotfiles | create_directories
    list_active_dotfiles | create_links
}

clean_up() {
    while read dotfile; do
        if [ -L ~/$dotfile ]; then
            execute rm ~/$dotfile
        elif [ -e ~/$dotfile ]; then
            execute mv ~/$dotfile ~/$dotfile.bak
        fi
    done
}

create_directories() {
    while read dotfile; do
        dir=$(dirname $dotfile)
        if [ ! -e ~/$dir ]; then
            execute mkdir ~/$dir
        fi
    done
}

create_links() {
    while read dotfile; do
        execute ln -s $(pwd)/$dotfile ~/$dotfile
    done
}

list_active_dotfiles() {
    echo .Xmodmap
    echo .bashrc
    echo .bashrc_files
    echo .gitconfig
    echo .gitignore.global
    echo .hgignore
    echo .hgrc
    echo .vim
    echo .vimrc
    echo .config/i3/config
    echo .config/i3/myi3status
    echo bin/sync-folders
    echo bin/gotosleep
    echo bin/command-client
    echo bin/command-server
    echo bin/rlselect
    echo bin/rlselect-history
    echo bin/o
    echo bin/find-files
    echo bin/find-dirs
    echo bin/vim-find-select
}

list_inactive_dotfiles() {
    echo .screenrc
    echo .xmonad/conkyrc
    echo .xmonad/xmonad.hs
    echo .i3status
    echo bin/f
    echo bin/se
    echo bin/e
}

execute() {
    echo '>' "$*"
    $*
}

install_dotfiles
