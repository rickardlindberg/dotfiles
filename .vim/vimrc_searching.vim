" = Search
set noignorecase
set hlsearch
set incsearch
set grepprg=ack

map ,h :let @/="\\<<C-R><C-W>\\>"<CR>

map <CR> :nohlsearch<CR>j
