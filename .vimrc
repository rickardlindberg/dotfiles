" = Plugin configuration
call pathogen#runtime_append_all_bundles("plugins")
let g:snippets_dir="~/.vim/snippets"

" = Filetype autodetection
filetype plugin indent on

" = Tab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

" = Search
set noignorecase
set hlsearch
set incsearch
set grepprg=ack

" = Completion
set nowildmenu
set wildmode=list:longest,full
set completeopt=longest,menu,preview
set wildignore=*.pyc,*.o,*.hi
set pumheight=20

" = Spell checking
set spell

" = Indent
set smartindent

" = Text display options
set textwidth=79
set scrolloff=3
set winwidth=80

" = Function: GoToPrevEditedFile
function! GoToPrevEditedFile()
    let currentFile = expand("%")
    while currentFile == expand("%")
        execute "normal \<c-o>"
    endwhile
endfunction

" = Refactorings
function! ExtractJsTestMethod() range
    let name = inputdialog("Name: ")
    if name == ""
        return
    endif
    let params = inputdialog("Parameters: ")
    let test_case_name = expand("%:t:r")
    execute a:firstline . "," . a:lastline . "d r"
    execute "normal Othis." . name . "(" . params . ");"
    execute "normal /^};$\<CR>"
    execute "normal o"
    execute "normal o" . test_case_name . ".prototype." . name . " = function (" . params . ") {"
    execute "normal o};"
    execute "normal \"rP"
endfunction

function! ExtractJsMethod() range
    let name = inputdialog("Name: ")
    if name == ""
        return
    endif
    let params = inputdialog("Parameters: ")
    execute a:firstline . "," . a:lastline . "d r"
    execute "normal Othis." . name . "(" . params . ");"
    execute "normal /  },$\<CR>"
    execute "normal o"
    execute "normal o" . name . ": function (" . params . ") {"
    execute "normal o},"
    execute "normal \"rP"
endfunction

" = Mappings
let mapleader = ","

map <F2> :cn<CR>
map <F7> :call GoToPrevEditedFile()<CR>
map <F11> :set syntax=mail<CR>
map <F12> :set spelllang=sv<CR>
nmap <Space> <C-f>
nmap <S-Space> <C-b>
noremap <C-]> :tj <C-r><C-w><CR>

map <Leader><Leader> <C-^>
map <Leader>fb :FufBuffer<CR>
map <Leader>sip vip:!sort<CR>
map <Leader>ew :e <C-R>=expand("%:p:h") . "/"<CR>
map <Leader>gt :!ctags --python-kinds=-i --extra=+f -R .
map <Leader>rw :%s/\<<C-R><C-W>\>/<C-R><C-W>/gc<Left><Left><Left>
map <Leader>h :let @/="\\<<C-R><C-W>\\>"<CR>
map <Leader>b :bd<CR>
map <Leader>sh V:!sh<CR>
map <Leader>qq :qall!<CR>
map <F5> :tj <C-r><C-w><CR>

if &diff
    map <C-q> :qall<CR>
    map <Up> [c
    map <Down> ]c
    map <Right> :diffget<CR>
endif

" = Autocommand clear
autocmd!

" = Refactoring mapping
autocmd BufEnter *.js
    \ vmap <buffer> <Leader>em :call ExtractJsMethod()<CR>
autocmd BufEnter **/test-js/**/*.js
    \ vmap <buffer> <Leader>em :call ExtractJsTestMethod()<CR>

" = No spell in cwindow
autocmd BufNewFile,BufReadPost * if &buftype != '' | setlocal nospell | endif

" = No spell in diff files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'diff' | setlocal nospell | endif

" = No spell in haskell files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'haskell' | setlocal nospell | endif

" = Project: vimrc
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufWritePost ~/.vim/* source ~/.vimrc

" = Python folding
function! PythonCommentFold()
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^\ *#'?'1':0
endfunction
autocmd BufReadPost *.py call PythonCommentFold()

" = UI
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
    colorscheme desertEx
else
    set background=light
    let g:solarized_termtrans = 1
    colorscheme solarized
endif

" = Local settings
if filereadable(expand("~/.vim/local.vim"))
    source ~/.vim/local.vim
endif
