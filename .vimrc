call pathogen#runtime_append_all_bundles("plugins")
" On some Linux systems, this is necessary to make sure pathogen picks up
" ftdetect directories in plugins! :(
filetype off
filetype plugin indent on

source ~/.vim/vimrc_auto.vim
source ~/.vim/vimrc_viewing.vim
source ~/.vim/vimrc_browsing.vim
source ~/.vim/vimrc_search_replace.vim
source ~/.vim/vimrc_editing.vim

if filereadable(expand("~/.vim/local.vim"))
    source ~/.vim/local.vim
endif
