set spell

map <F11> :set syntax=mail<CR>
map <F12> :set spelllang=sv<CR>

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
    set background=light
else
    set background=light
    let g:solarized_termtrans = 1
    colorscheme solarized
endif

set colorcolumn=+1
