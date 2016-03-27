#!/bin/sh

install_dotfiles() {
    cd $(dirname "$0")
    clean_up_old
    create_directories
    create_links
}

clean_up_old() {
    for dotfile in $(list_dotfiles); do
        if [ -L ~/$dotfile ]; then
            execute rm ~/$dotfile
        elif [ -e ~/$dotfile ]; then
            execute mv ~/$dotfile ~/$dotfile.bak
        fi
    done
}

create_directories() {
    for dotfile in $(list_dotfiles); do
        dir=$(dirname $dotfile)
        if [ ! -e ~/$dir ]; then
            execute mkdir ~/$dir
        fi
    done
}

create_links() {
    for dotfile in $(list_dotfiles); do
        execute ln -s $(pwd)/$dotfile ~/$dotfile
    done
}

list_dotfiles() {
    echo .Xmodmap
    echo .bashrc
    echo .bashrc_files
    echo .gitconfig
    echo .gitignore.global
    echo .hgignore
    echo .hgrc
    echo .screenrc
    echo .vim
    echo .vimrc
    echo .xmonad/conkyrc
    echo .xmonad/xmonad.hs
    echo .config/i3/config
    echo bin/sync-folders
}

execute() {
    echo '>' "$*"
    $*
}

install_dotfiles
