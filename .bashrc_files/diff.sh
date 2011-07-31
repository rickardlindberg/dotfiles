vidiff() {
    if _inside_hg_repo; then
        hg diff | vi -
    fi
}

_inside_hg_repo() {
    hg status > /dev/null 2>&1
}
