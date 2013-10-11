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

map ,sip vip:!sort<CR>
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
