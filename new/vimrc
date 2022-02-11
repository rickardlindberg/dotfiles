" TODO: add abbreviations as a poor-mans-snippets
"       https://vonheikemen.github.io/devlog/tools/using-vim-abbreviations/

autocmd!
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'yaml' | setlocal sw=2 sts=2 | endif
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'css' | setlocal sw=2 sts=2 | endif
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'html' | setlocal sw=2 sts=2 | endif
autocmd BufNewFile,BufReadPost,StdinReadPost *.rlmeta set syntax=rlmeta nospell
if has("gui_running")
    autocmd BufWritePost * execute "silent !command-server --invoke <afile>"
else
    " The explicit redraw only seems to be needed in console Vim.
    autocmd BufWritePost * execute "silent !command-server --invoke <afile>" | redraw!
endif

set spell

syntax enable
set laststatus=2      " Always show status line for a window

" Highlight extra whitespace
highlight ExtraWhiteSpace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhiteSpace guibg=red
au BufEnter * match ExtraWhiteSpace /\s\+$/
au InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

if has("gui_running")
    set guioptions-=T " Hide toolbar
    set guioptions+=c " Use console dialogs
    set guioptions-=m " Hide menu bar
    set guioptions-=r " Hide right scroll bar
    set guioptions-=R
    set guioptions-=l " Hide left scroll bar
    set guioptions-=L
    colorscheme solarized
    set background=dark
    set guifont=Monospace\ 12
else
    set background=dark
    let g:solarized_termtrans = 1
    colorscheme solarized
endif

set colorcolumn=+1

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
    let selection = system("vim-find-select | " . rlselect_command . " 2>/dev/null", buffersout)
    if ! has("gui_running")
        redraw!
    endif
    if strpart(selection, 0, 1) == "b"
        exec ":b " . strpart(selection, 2)
    elseif strpart(selection, 0, 1) == "t"
        exec ":tj " . strpart(selection, 2)
    elseif strlen(selection) > 0
        exec ":e " . substitute(strpart(selection, 2), " ", "\\\\ ", "g")
    endif
endfunction

nmap <C-t> :call Rlselect()<CR>

set noignorecase
set hlsearch
set incsearch
set grepprg=ack

map ,h :let @/="\\<<C-R><C-W>\\>"<CR>
nnoremap <CR> :nohlsearch<CR><CR>
map ,rw :call SubstituteInFile(expand("<cword>"))<CR>
map ,mrw :call SubstituteInCodebase(expand("<cword>"))<CR>
map ,mrW :call SubstituteInCodebase(expand("<cWORD>"))<CR>

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

map ,sip vip:!sort<CR>
