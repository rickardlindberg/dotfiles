set noignorecase
set hlsearch
set incsearch
set grepprg=ack

map ,h :let @/="\\<<C-R><C-W>\\>"<CR>

nnoremap <CR> :nohlsearch<CR><CR>
