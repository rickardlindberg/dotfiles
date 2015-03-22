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
