let g:snippets_dir="~/.vim/snippets"

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

set textwidth=79
set winwidth=80

set smartindent

set nowildmenu
set wildmode=list:longest,full
set completeopt=longest,menu,preview
set wildignore=*.pyc,*.o,*.hi
set pumheight=20

map <F5> :source ~/.vimrc<CR>
map ,sip vip:!sort<CR>
map ,rw :call SubstituteInFile(expand("<cword>"))<CR>
map ,mrw :call SubstituteInCodebase(expand("<cword>"))<CR>

function! SubstituteInFile(text)
    execute GetSubstituteCommand("%", a:text)
endfunction

function! SubstituteInCodebase(text)
    let grepCommand = GetGrepCommand(a:text)
    let substituteCommand = GetSubstituteCommand("", a:text)
    execute grepCommand
    call QuickfixDo(substituteCommand . " | update")
endfunction

function! GetGrepCommand(term)
  return "grep " . input(":grep ", "-w '" . a:term . "'\<C-f>F'F'l")
endfunction

function! GetSubstituteCommand(range, term)
  return a:range . "s" . input(":s", "/\\<" . a:term . "\\>/" . a:term . "/gc\<C-f>F/F/l")
endfunction

function! QuickfixDo(command)
    let itemCount = len(getqflist())
    let itemNr = 1
    while itemNr <= itemCount
        exe "cc " . itemNr
        exe a:command
        let itemNr = itemNr + 1
    endwhile
endfunction
