#!/usr/bin/env bash

set -e

main() {
    mkdir -p ~/bin
    mkdir -p ~/.config/git
    rm -rf ~/.vim
    mkdir -p ~/.vim/syntax
    mkdir -p ~/.vim/colors

    install_file 3rd-party/solarized.vim ~/.vim/colors
    install_file bashrc                  ~/.bashrc                 "$@"
    install_file vimrc                   ~/.vimrc                  "$@"
    install_file vim_syntax_rlmeta.vim   ~/.vim/syntax/rlmeta.vim  "$@"
    install_file rlselect                ~/.rlselect.cfg           "$@"
    install_file gitconfig               ~/.config/git/config      "$@"
    install_file gitignore               ~/.config/git/ignore      "$@"
    install_file hgrc                    ~/.hgrc                   "$@"
    install_file hgignore                ~/.hgignore               "$@"

    install_file i3                      ~/.config/i3/config       "$@"
    install_file xmodmap                 ~/.Xmodmap                "$@"
    run i3-msg restart
}

install_file() {
    name="$1"
    destination="$2"
    shift
    shift
    run cp "$name" "$destination"
    while [ -n "$1" ]; do
        apply_addon "$name.$1" "$destination"
        apply_addon "_post.$1" "$destination"
        shift
    done
}

apply_addon() {
    addon="$1"
    destination="$2"
    if [ -e "$addon" ]; then
        run sed -i -f "$addon" "$destination"
    fi
}

run() {
    echo "$@"
    "$@"
}

main "$@"
