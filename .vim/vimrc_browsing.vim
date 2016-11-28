set scrolloff=3

nmap <Space> <C-f>
nmap <S-Space> <C-b>
noremap <C-]> :tj <C-r><C-w><CR>
map ,fb :call Rlselect()<CR>
map ,ew :e <C-R>=expand("%:p:h") . "/"<CR>
map ,b :bd<CR>
map ,qq :qall!<CR>
map ,xo :!xdg-open <cfile> &<CR>
map ,gt :!ctags --python-kinds=-i --extra=+f -R .
map ,tt :NERDTree<CR>

let g:tagbar_compact = 1
let g:tagbar_width = 60
let g:tagbar_sort = 0
map ,o :TagbarOpenAutoClose<CR>

nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
map ,, <C-^>

let NERDTreeIgnore=['.pyc$']

function! Rlselect()
    if has("gui_running")
        let rlselect_command="rlselect --gui"
    else
        let rlselect_command="rlselect"
    endif
    let bufnrs = filter(range(1, bufnr("$")), 'buflisted(v:val)')
    let buffers = map(bufnrs, 'bufname(v:val)')
    let buffersout = join(buffers, "\n") . "\n"
    let selection = system("vim-find-select | " . rlselect_command, buffersout)
    if ! has("gui_running")
        redraw!
    endif
    if strpart(selection, 0, 1) == "b"
        exec ":b " . strpart(selection, 2)
    elseif strpart(selection, 0, 1) == "t"
        exec ":tj " . strpart(selection, 2)
    elseif strlen(selection) > 0
        exec ":e " . strpart(selection, 2)
    endif
endfunction

nmap <C-t> :call Rlselect()<CR>
