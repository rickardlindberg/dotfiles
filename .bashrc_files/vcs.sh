export AUTHOR_RL_RS='--author="Rickard Lindberg and Rasmus Svensson <ricli85+raek@gmail.com>"'
export AUTHOR_RL_KG='--author="Rickard Lindberg and Kajsa Goffrich <ricli85+kajgo@gmail.com>"'

s() {
    if _is_inside_git_repo; then
        git branch
        git status "$@"
    elif _is_inside_hg_repo; then
        hg status "$@"
    elif _is_inside_svn_repo; then
        svn status "$@"
    elif _is_inside_svn_container_repo; then
        _do_on_svn_dirs status "$@"
    else
        echo "No repository found"
    fi
}

d() {
    if _is_inside_git_repo; then
        git diff "$@" | vi -
    elif _is_inside_hg_repo; then
        hg diff "$@" | vi -
    elif _is_inside_svn_repo; then
        svn diff "$@" | vi -
    else
        echo "No repository found"
    fi
}

vd() {
    if _is_inside_git_repo; then
        git difftool -d -t kompare "$@"
    elif _is_inside_hg_repo; then
        hg vdiff "$@"
    elif _is_inside_svn_repo; then
        svn diff "$@"
    else
        echo "No repository found"
    fi
}

c() {
    if _is_inside_git_repo; then
        git-cola "$@"
    elif _is_inside_hg_repo; then
        qct "$@"
    elif _is_inside_svn_repo; then
        svn commit "$@"
    else
        echo "No repository found"
    fi
}

h() {
    if _is_inside_git_repo; then
        gitk --all "$@"
    elif _is_inside_hg_repo; then
        hg view "$@"
    elif _is_inside_svn_repo; then
        svn log "$@"
    else
        echo "No repository found"
    fi
}

_is_inside_git_repo() {
    git status > /dev/null 2>&1
}

_is_inside_hg_repo() {
    hg status > /dev/null 2>&1
}

_is_inside_svn_repo() {
    [ -d .svn ]
}

_is_inside_svn_container_repo() {
    for dir in *; do
        [ -d "$dir/.svn" ] && return 0
    done
    return 1
}

_do_on_svn_dirs() {
    for dir in *; do
        if [ -d "$dir/.svn" ]; then
            svn "$@" "$dir"
        fi
    done
}
