vidiff() {
    if _inside_hg_repo; then
        hg diff | vi -
    elif _inside_svn_repo; then
        svn diff | vi -
    fi
}

_inside_hg_repo() {
    hg status > /dev/null 2>&1
}

_inside_svn_repo() {
    [ -d .svn ]
}
