set scrolloff=3

nmap <Space> <C-f>
nmap <S-Space> <C-b>
noremap <C-]> :tj <C-r><C-w><CR>
map ,fb :FufBuffer<CR>
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
