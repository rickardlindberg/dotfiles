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
        execute ln -s -T $(pwd)/$dotfile ~/$dotfile
    done
}

list_dotfiles() {
    files_in_repo | remove_non_dotfiles | treat_direcotry_as_single
}

files_in_repo() {
    git ls-tree -r --name-only HEAD
}

remove_non_dotfiles() {
    grep -v '^\(install.sh\|\.gitignore\)'
}

treat_direcotry_as_single() {
    grep -v '^\(\.vim/.\)'
    echo '.vim'
}

execute() {
    echo '>' "$*"
    $*
}

install_dotfiles
