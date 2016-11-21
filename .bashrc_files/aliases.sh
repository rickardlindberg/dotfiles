alias ll="ls -l"
alias o=xdg-open
alias tp=trash-put

p() {
    local selection
    selection="$(find-dirs ~ 5 | rlselect)"
    if [ $? = 0 ]; then
        cd "$selection"
    fi
}

cdi() {
    local selection
    selection="$(find-dirs . 10 | rlselect)"
    if [ $? = 0 ]; then
        cd "$selection"
    fi
}
