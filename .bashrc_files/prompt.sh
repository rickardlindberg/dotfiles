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
    for color in {1..100}; do
        export PS1="$PS1\n[$(_in_color $color "color $color")]"
    done
}

export PS1=""
export PS1="$PS1\n"
export PS1="$PS1$(_in_color 96 '\u@\h') "
export PS1="$PS1$(_in_color 37 '$(date "+%H:%M")') "
export PS1="$PS1$(_in_color 93 '\w')"
export PS1="$PS1$(_in_color 91 '$(_svn_prompt)')"
export PS1="$PS1\n"
export PS1="$PS1\$ "
