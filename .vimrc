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
set wildignore=*.pyc

" = Spell checking
set spell

" = Indent
set smartindent

" = Text display options
set textwidth=79
set scrolloff=3

" = Function: GoToPrevEditedFile
function! GoToPrevEditedFile()
    let currentFile = expand("%")
    while currentFile == expand("%")
        execute "normal \<c-o>"
    endwhile
endfunction

" = Mappings 
map <F2> :cn<CR>
map <F7> :call GoToPrevEditedFile()<CR>
map <F11> :set syntax=mail<CR>
map <F12> :set spelllang=sv<CR>
nmap <Space> <C-f>
nmap <S-Space> <C-b>
noremap <C-]> :tj <C-r><C-w><CR>

map <Leader>ft :FufTag<CR>
map <Leader>fb :FufBuffer<CR>
map <Leader>sip vip:!sort<CR>
map <Leader>ew :e <C-R>=expand("%:p:h") . "/"<CR>
map <Leader>fpc ?^class
map <Leader>sj :grep --js ""<Left>
map <Leader>sp :grep --python ""<Left>
map <Leader>gt :!ctags --python-kinds=-i --extra=+f -R .<CR>

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

" = Project: vimrc
function! FoldMethodForVimrc()
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v:lnum)=~'^\"\ =\ '?'>1':1
endfunction
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufWritePost ~/.vim/* source ~/.vimrc
autocmd BufReadPost ~/.vimrc call FoldMethodForVimrc()
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
