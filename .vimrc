" = Plugin configuration
call pathogen#runtime_append_all_bundles("plugins")
let g:snippets_dir="~/.vim/snippets"

" = Filetype autodetection
filetype off " On some Linux systems, this is necessary to make sure pathogen
             " picks up ftdetect directories in plugins! :(
filetype plugin indent on

source ~/.vim/vimrc_editing.vim
source ~/.vim/vimrc_searching.vim
source ~/.vim/vimrc_browsing.vim
source ~/.vim/vimrc_viewing.vim

" = Completion
set nowildmenu
set wildmode=list:longest,full
set completeopt=longest,menu,preview
set wildignore=*.pyc,*.o,*.hi
set pumheight=20

" = Mappings
let mapleader = ","

map <Leader>gt :!ctags --python-kinds=-i --extra=+f -R .
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

" = Rename
map ,rw :%s/\<<C-R><C-W>\>/<C-R><C-W>/gc<C-f>F/F/l
map ,mrw :call MultipleFileRename()<CR>

" Alternative: http://www.ibrahim-ahmed.com/2008/01/find-and-replace-in-multiple-files-in.html
function! MultipleFileRename()
  let grep_cmd = input(":grep ", "\"\\b" . expand('<cword>') . "\\b\"")
  let replace_cmd = input(":s", "/\\<" . expand('<cword>') . "\\>/" . expand('<cword>') . "/gc\<C-f>F/F/l")
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

" = Local settings
if filereadable(expand("~/.vim/local.vim"))
    source ~/.vim/local.vim
endif
