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

" .vimrc
autocmd BufWritePost ~/.vimrc source ~/.vimrc
autocmd BufWritePost ~/.vim/* source ~/.vimrc

" .xmonad/xmonad.hs
autocmd BufWritePost ~/.xmonad/xmonad.hs !xmonad --recompile
