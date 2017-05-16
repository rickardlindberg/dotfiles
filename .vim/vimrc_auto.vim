" Clear
autocmd!

" Don't wrap lines in textile files
autocmd BufEnter *.textile set tw=0

" No spell in cwindow
autocmd BufNewFile,BufReadPost * if &buftype != '' | setlocal nospell | endif

" No spell in diff files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'diff' | setlocal nospell | endif

" No spell in Haskell files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'haskell' | setlocal nospell | endif

" No spell in Erlang files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'erlang' | setlocal nospell | endif

" 2 space indent in yaml files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'yaml' | setlocal sw=2 sts=2 | endif

" 2 space indent in css files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'css' | setlocal sw=2 sts=2 | endif

" 2 space indent in html files
autocmd BufNewFile,BufReadPost,StdinReadPost * if &filetype == 'html' | setlocal sw=2 sts=2 | endif

" .xmonad/xmonad.hs
autocmd BufWritePost ~/.xmonad/xmonad.hs !xmonad --recompile

" command-server
" The explicit redraw only seems to be needed in console Vim.
if has("gui_running")
    autocmd BufWritePost * execute "silent !command-server --invoke <afile>"
else
    autocmd BufWritePost * execute "silent !command-server --invoke <afile>" | redraw!
endif
