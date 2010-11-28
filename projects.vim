" Examples
" function! SetupCompilerForProjFoo()
"     compiler pyunit
"     setlocal makeprg=python\ ~/proj-foo/tests/run.py
" endfunction
" autocmd BufWritePost ~/proj-foo/* :make
" autocmd BufReadPost ~/proj-foo/* call SetupCompilerForProjFoo()

if filereadable("projects-local.vim")
    source projects-local.vim
endif
