onhgout() {
    for rev in $(hg out | grep ^changeset: | tr ':' ' ' | awk '{print $3}'); do
        summary=$(hg log -r$rev --template '{desc|firstline}')
        printf "%s" "$rev ($summary)... "
        if hg up -r$rev > /dev/null 2>&1 && hg purge --all && $* > /dev/null 2>&1; then
            echo OK
        else
            echo FAIL
        fi
    done
}
