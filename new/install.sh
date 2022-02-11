#!/usr/bin/env bash

set -e

# TODO: install solarized color scheme
# TODO: improve configuration of gnome terminal

main() {
    mkdir -p ~/bin
    rm -r ~/.vim
    mkdir -p ~/.vim/syntax
    mkdir -p ~/.vim/colors
    install_file 3rd-party/solarized.vim ~/.vim/colors
    install_file vimrc                   ~/.vimrc                  "$@"
    install_file vim_syntax_rlmeta.vim   ~/.vim/syntax/rlmeta.vim  "$@"
    install_file rlselect                ~/.rlselect.cfg           "$@"
    install_file i3                      ~/.config/i3/config       "$@"
    install_bin  bin.setup_record                                  "$@"
    configure_gnome_terminal                                       "$@"
    run i3-msg restart
}

install_bin() {
    name="$1"
    destination=~/bin/$(echo "$name" | sed 's/^bin.//')
    shift
    install_file "$name" "$destination" "$@"
    run chmod +x "$destination"
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

configure_gnome_terminal() {
    # https://ncona.com/2019/11/configuring-gnome-terminal-programmatically/
    if echo "$@" | ack -w record; then
        run gsettings set org.gnome.Terminal.ProfilesList default "1f9fd30e-317a-4ebc-9154-fddd444aedf3"
    else
        run gsettings set org.gnome.Terminal.ProfilesList default "b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
    fi
}

run() {
    echo "$@"
    "$@"
}

main "$@"
