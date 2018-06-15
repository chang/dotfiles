syntax on
filetype on
filetype plugin on
filetype indent on
set nowrap
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set smartindent
set showcmd
set formatoptions-=ro                 " don't auto insert comment characters
set t_Co=256                          " 256 color
set termguicolors                     " truecolor
set hlsearch incsearch                " highlight found characters
set backspace=start,eol,indent        " allow backspacing past the INSERT
set omnifunc=syntaxcomplete#Complete  " use omnicompletion

" swap files get in the way
set swapfile
set dir=/Users/eric/.swapfiles  " create this directory if it doesn't exist

" vertical split line formatting
" :set fillchars+=vert:\

""" KEYMAPS
nmap ; :
nmap 4 0
" inoremap kj <Esc>

" CAPS is remapped in Mac under Keyboard -> Modifier Keys
" map <SPACE> <leader>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow  " split in same location as iterm
set splitright

""" PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible/'

"" Navigation
Plug 'tpope/vim-commentary'           " easier than nerdcommenter (gc)
Plug 'scrooloose/nerdtree'
Plug 'ajh17/VimCompletesMe'           " easier than supertab
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'               " :Files Ag Buffers Commands
Plug 'tpope/vim-surround'             " :s_, cs_, ys(obj)_
Plug 'terryma/vim-multiple-cursors'
Plug 'brooth/far.vim'                 " find and replace
Plug 'jiangmiao/auto-pairs'
Plug 'tommcdo/vim-lion'               " gl{} and gL{} to align on a character
Plug 'AndrewRadev/splitjoin.vim'      " gS and gJ to split and join lines
 
"" Aesthetics
Plug 'junegunn/goyo.vim'        " distraction free mode
Plug 'blueyed/vim-diminactive'  " dim inactive panes

"" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'sickill/vim-monokai'

Plug 'itchyny/lightline.vim'
set laststatus=2

"" Languages
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["scala"] }

"" Python
" Plug 'davidhalter/jedi-vim'  " has issues with hanging on completion
let g:python_highlight_all = 1

"" Scala
" Ensime has a 300ms+ load time
Plug 'ensime/ensime-vim', { 'for': 'scala' }

"" Haskell
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
let g:LanguageClient_serverCommands = { 'haskell': ['hie', '--lsp'] }

call plug#end()


colo palenight
" http://vimgolf.com/
