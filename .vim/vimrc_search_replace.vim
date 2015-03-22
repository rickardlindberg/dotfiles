set noignorecase
set hlsearch
set incsearch
set grepprg=ack

map ,h :let @/="\\<<C-R><C-W>\\>"<CR>
nnoremap <CR> :nohlsearch<CR><CR>
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
