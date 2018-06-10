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

"" Navigation
Plug 'tpope/vim-commentary'  " easier than nerdcommenter (gc)

Plug 'scrooloose/nerdtree'
" autocmd VimEnter * if !argc() | NERDTree | endif

Plug 'ajh17/VimCompletesMe'  " easier than supertab
"Plug 'ervandew/supertab'
"" have supertab use omnicomplete by default with user complete as a fallback
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType *
    "\ if &omnifunc != '' |
    "\   call SuperTabChain(&omnifunc, "<c-p>") |
    "\ endif

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'  " :Files Ag Buffers Commands

" ds_, cs_, ys(obj)_
Plug 'tpope/vim-surround'

Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_quit_key            = '<Esc>'

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

"" Python
" Plug 'davidhalter/jedi-vim'  " has issues with hanging on completion
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

"" Scala
" Ensime has a 300ms+ load time
Plug 'ensime/ensime-vim', { 'for': 'scala' }
Plug 'derekwyatt/vim-scala'

"" Haskell
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
" let g:LanguageClient_serverCommands = { 'haskell': ['hie', '--lsp'] }

call plug#end()

" automatically reload vimrc while editing vimrc
let vimrc_path = "/Users/eric/.vimrc"
autocmd BufWritePost vimrc_path so vimrc_path

colo palenight
" http://vimgolf.com/
