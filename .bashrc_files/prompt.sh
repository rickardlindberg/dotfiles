_in_color() {
    echo "\e[0;$1m$2\e[m"
}

_svn_prompt() {
    if [ -d .svn ]; then
        if (( $(svn stat | wc -l) != 0 )); then
            echo " (*)"
        fi
    fi
}

_add_colors_to_ps1() {
    for color in {1..50}; do
        export PS1="$PS1\n$(_in_color $color "this is color $color")"
    done
}

export PS1=""
export PS1="$PS1\n"
export PS1="$PS1$(_in_color 36 '\u@\h') "
export PS1="$PS1$(_in_color 37 '$(date "+%H:%M")') "
export PS1="$PS1$(_in_color 33 '\w')"
export PS1="$PS1$(_in_color 31 '$(_svn_prompt)')"
export PS1="$PS1\n"
export PS1="$PS1$ "
