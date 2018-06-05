" basic syntax stuff
syntax on
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent


" filetype specific plugins
filetype on
filetype plugin on
filetype indent on

"

" highlight found characters
set hlsearch incsearch

" space is nice
let mapleader=" "


" Plugins (junegunn/vim-plug)
call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ervandew/supertab'

call plug#end()
