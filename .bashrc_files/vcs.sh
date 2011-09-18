s() {
    _is_inside_git_repo && git status && return
    _is_inside_hg_repo  && hg status && return
    echo "No repository found"
}

d() {
    if _is_inside_git_repo; then
        git diff
    elif _is_inside_hg_repo; then
        hg diff
    fi | vi -
}

_is_inside_git_repo() {
    git status > /dev/null 2>&1
}

_is_inside_hg_repo() {
    hg status > /dev/null 2>&1
}
