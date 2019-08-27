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
" set t_Co=256                          " 256 color
set termguicolors                     " truecolor
set hlsearch incsearch                " highlight found characters
set backspace=start,eol,indent        " allow backspacing past the INSERT
set omnifunc=syntaxcomplete#Complete  " use omnicompletion
set ignorecase                        " case insensitive search
set relativenumber

" swap files get in the way
set swapfile
set dir=~/.swapfiles  " create this directory if it doesn't exist

" copy and paste from the system terminal and across vim instances
" :echo has('clipboard') must return 1 for this to work
" set clipboard=unnamedplus

""" KEYMAPS
" ugh I like this but then I can't use ; to repeat motions...
" nmap ; :
" inoremap kj <Esc>

" CAPS is remapped in Mac under Keyboard -> Modifier Keys
" map <SPACE> <leader>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow 
set splitright

" File finding
" Requires vim fzf
nnoremap <C-P> :Files <CR>

"" PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible/'

"" Navigation
Plug 'tpope/vim-commentary'           " easier than nerdcommenter (gc)
Plug 'ajh17/VimCompletesMe'           " easier than supertab
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'               " :Files Ag Buffers Commands
Plug 'tpope/vim-surround'             " :s_, cs_, ys(obj)_
Plug 'terryma/vim-multiple-cursors'
Plug 'brooth/far.vim'                 " find and replace
Plug 'jiangmiao/auto-pairs'

Plug 'terryma/vim-smooth-scroll'      " scroll smoothly with ctrl+d ctrl+u 
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
 
"" Aesthetics
Plug 'junegunn/goyo.vim'        " distraction free mode
Plug 'blueyed/vim-diminactive'  " dim inactive panes
Plug 'junegunn/limelight.vim'

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
" Plug 'vim-syntastic/syntastic'

"" Python
" Plug 'davidhalter/jedi-vim'  " has issues with hanging on completion
let g:python_highlight_all = 1

"" Scala
" Ensime has a 300ms+ load time
" Plug 'ensime/ensime-vim', { 'for': 'scala' }

"" Haskell
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
" let g:LanguageClient_serverCommands = { 'haskell': ['hie', '--lsp'] }

call plug#end()

"" Markdown
autocmd Filetype markdown setlocal wrap linebreak


" http://vimgolf.com/
colo monokai_pro
