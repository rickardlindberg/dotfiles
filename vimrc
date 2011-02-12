" = Plugin: SnipMate
set runtimepath+=~/.vim/plugin-snipmate-0.83
set runtimepath+=~/.vim/plugin-snipmate-0.83/after
let g:snippets_dir="~/.vim/snippets"

" = Plugin: vcscommand
set runtimepath+=~/.vim/plugin-vcscommand-1.99.42

" = Plugin: bufkill
set runtimepath+=~/.vim/plugin-bufkill-1.9

" = Completion
set nowildmenu
set wildmode=list:longest,full
set completeopt=longest,menu,preview

" = Wildcard
set wildignore=*.pyc

" = Grep
set grepprg=ack

" = Filetype autodetection
filetype plugin indent on

" = Spell checking
set spell

" = Search options 
set ignorecase
set smartcase
set hlsearch
set incsearch

" = Tab settings 
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

" = Indent option
set smartindent

" = Text display options
set textwidth=79
set scrolloff=3

" = Mappings 
map <F2> :cn<CR>
map <F11> :set syntax=mail<CR>
map <F12> :set spelllang=sv<CR>
nmap <Space> <C-f>
nmap <S-Space> <C-b>
map <Leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <C-]> :tj <C-r><C-w><CR>

if &diff
    map <C-q> :qall<CR>
    map <Up> [c
    map <Down> ]c
    map <Right> :diffget<CR>
endif

" = Autocommand clear 
autocmd!

" = No spell in cwindow
autocmd BufNewFile,BufReadPost * if &buftype != '' | setlocal nospell | endif 

" = Project: Example
" function! SetupCompilerForProjFoo()
"     compiler pyunit
"     setlocal makeprg=python\ ~/proj-foo/tests/run.py
" endfunction
" autocmd BufWritePost ~/proj-foo/* :make
" autocmd BufReadPost ~/proj-foo/* call SetupCompilerForProjFoo()

" = Project: vimrc
function! FoldMethodForVimrc()
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^\"\ =\ '?'>1':1
endfunction
autocmd BufWritePost ~/.vim/* source ~/.vimrc
autocmd BufReadPost ~/.vim/vimrc call FoldMethodForVimrc()
autocmd BufReadPost ~/.vim/local.vim call FoldMethodForVimrc()

" = UI 
syntax enable
colorscheme murphy
set laststatus=2      " Always show status line for a window

if has("gui_running")
    set guioptions-=T " Hide toolbar
    set guioptions+=c " Use console dialogs
    set guioptions-=m " Hide menu bar
    set guioptions-=r " Hide right scroll bar
    set guioptions-=R
    set guioptions-=l " Hide left scroll bar
    set guioptions-=L
    colorscheme candycode
endif

" = Local settings
if filereadable(expand("~/.vim/local.vim"))
    source ~/.vim/local.vim
endif
