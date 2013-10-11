" = Plugin configuration
call pathogen#runtime_append_all_bundles("plugins")
let g:snippets_dir="~/.vim/snippets"

" = Filetype autodetection
filetype off " On some Linux systems, this is necessary to make sure pathogen
             " picks up ftdetect directories in plugins! :(
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
set colorcolumn=+1

" = Mappings
let mapleader = ","

map <F2> :cn<CR>
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
map <Leader>h :let @/="\\<<C-R><C-W>\\>"<CR>
map <Leader>b :bd<CR>
map <Leader>sh V:!sh<CR>
map <Leader>qq :qall!<CR>
map <Leader>xo :!xdg-open <cfile> &<CR>

" = Autocommand clear
autocmd!

" = Don't wrap lines in textile files
autocmd BufEnter *.textile set tw=0

" = No spell in cwindow
autocmd BufNewFile,BufReadPost * if &buftype != '' | setlocal nospell | endif

" = No spell in diff files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'diff' | setlocal nospell | endif

" = No spell in haskell files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'haskell' | setlocal nospell | endif

" = Project: vimrc
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufWritePost ~/.vim/* source ~/.vimrc

" = Project: .xmonad/xmonad.hs
autocmd BufWritePost ~/.xmonad/xmonad.hs !xmonad --recompile

" = Browse
let g:tagbar_compact = 1
let g:tagbar_width = 60
let g:tagbar_sort=0
map ,o :TagbarOpenAutoClose<CR>

" = Rename
map ,rw :%s/\<<C-R><C-W>\>/<C-R><C-W>/gc<C-f>F/F/l
map ,mrw :call MultipleFileRename()<CR>

" Alternative: http://www.ibrahim-ahmed.com/2008/01/find-and-replace-in-multiple-files-in.html
function! MultipleFileRename()
  let grep_cmd = input(":grep ", expand('<cword>'))
  let replace_cmd = input(":s", "/\\<" . expand('<cword>') . "\\>/" . expand('<cword>') . "/gc\<C-f>")
  try
    exe "grep " . grep_cmd
    crewind
    while 1
        exe "s" . replace_cmd
        update
      try
        cnext
      catch
        return
      endtry
    endwhile
  catch
  endtry
endfunction

" = Test
let g:rl_tests=""
function! UpdateRlTests()
  let g:rl_tests = input("Tests: ", g:rl_tests)
endfunction
map ,ts :call UpdateRlTests()<CR>

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
    colorscheme solarized
    set background=light
else
    set background=light
    let g:solarized_termtrans = 1
    colorscheme solarized
endif

" = Local settings
if filereadable(expand("~/.vim/local.vim"))
    source ~/.vim/local.vim
endif
