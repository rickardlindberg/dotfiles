alias ll="ls -l"
alias o=xdg-open
alias tp=trash-put

f() {
    local program
    if [ "$1" = "" ]; then
        program=vim
    else
        program="$1"
    fi
    "$program" $( \
        find . \
            -type d -name .git -prune \
            -o \
            -type d -name .vim -prune \
            -o \
            -type d -name .hg -prune \
            -o \
            -type d -name __pycache__ -prune \
            -o \
            -type d -name venv -prune \
            -o \
            -type d -name .cache -prune \
            -o \
            -type f -name .*swp -prune \
            -o \
            -type f -name *pyc -prune \
            -o \
            -type f -print \
        | rlselect \
    )
}
