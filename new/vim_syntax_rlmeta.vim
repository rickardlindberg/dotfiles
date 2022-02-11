if exists("b:current_syntax")
    finish
endif

syntax keyword metaKeyword label
syntax keyword metaKeyword indentprefix
syntax keyword metaKeyword list
syntax keyword metaKeyword dict
syntax keyword metaKeyword add
syntax keyword metaKeyword get
syntax keyword metaKeyword set
syntax keyword metaKeyword len
syntax keyword metaKeyword int

syntax region metaString start=+"+ end=+"+ skip=+\\'\|\\"\|\\\\\|\\n\|\\t+

syntax region metaChars start=+'+ end=+'+ skip=+\\'\|\\"\|\\\\\|\\n\|\\t+

syntax match metaPatternOperator +[|]+
syntax match metaPatternOperator +[*]+
syntax match metaPatternOperator +[!]+
syntax match metaPatternOperator +[.]+

syntax match metaActionOperator +[>]+
syntax match metaActionOperator +[<]+
syntax match metaActionOperator +[~]+

syntax match metaSeparatorOperator +[-][>]+
syntax match metaSeparatorOperator +[=]+

syntax match metaCommonOperator +[:]+

syntax sync fromstart

"hi def link metaKeyword           Keyword
hi def link metaString            String
hi def link metaSeparatorOperator Todo
hi def link metaChars             Underlined
hi def link metaActionOperator    Macro
hi def link metaPatternOperator   Operator
hi def link metaCommonOperator    Comment

let b:current_syntax = "rlmeta"
