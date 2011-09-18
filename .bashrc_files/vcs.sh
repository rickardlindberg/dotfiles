s() {
    _is_inside_git_repo && git status && return
    _is_inside_hg_repo  && hg status && return
    echo "No repository found"
}

_is_inside_git_repo() {
    git status > /dev/null 2>&1
}

_is_inside_hg_repo() {
    hg status > /dev/null 2>&1
}
