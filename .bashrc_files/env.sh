export PATH=$HOME/.cabal/bin:$HOME/bin:$PATH
export EDITOR=vim

g() {
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
