if exists("b:current_syntax")
    finish
endif

syntax keyword metaKeyword actor
"syntax keyword metaKeyword def
syntax keyword metaKeyword where
syntax keyword metaKeyword examples
syntax keyword metaKeyword universe

syntax region metaString start=+"+ end=+"+ skip=+\\'\|\\"\|\\\\\|\\n\|\\t+

syntax region metaChars start=+'+ end=+'+ skip=+\\'\|\\"\|\\\\\|\\n\|\\t+

syntax region metaDef start=+^def.*$+ end=+^+ skip=+^ .*$+ contains=python

syntax match metaPatternOperator +[|]+
syntax match metaPatternOperator +[*]+
syntax match metaPatternOperator +[!]+
syntax match metaPatternOperator +[.]+

syntax match metaActionOperator +[~]+

syntax match metaSeparatorOperator +[-][>]+
syntax match metaSeparatorOperator +[=]+

syntax match metaCommonOperator +[:]+

syntax sync fromstart

hi def link metaKeyword           Keyword
hi def link metaString            String
hi def link metaDef               Macro
hi def link metaSeparatorOperator Todo
hi def link metaChars             Underlined
hi def link metaActionOperator    Macro
hi def link metaPatternOperator   Operator
hi def link metaCommonOperator    Comment

let b:current_syntax = "rlmeta"
