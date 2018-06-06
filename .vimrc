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
map <SPACE> <leader>

""" PLUGINS
call plug#begin('~/.vim/plugged')

"" Navigation
Plug 'scrooloose/nerdcommenter'

Plug 'scrooloose/nerdtree'
autocmd VimEnter * if !argc() | NERDTree | endif


Plug 'ajh17/VimCompletesMe'
"Plug 'ervandew/supertab'
"" have supertab use omnicomplete by default with user complete as a fallback
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"autocmd FileType *
    "\ if &omnifunc != '' |
    "\   call SuperTabChain(&omnifunc, "<c-p>") |
    "\ endif

Plug 'junegunn/vim-easy-align'
xmap ea <Plug>(EasyAlign)

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'  " :Files Ag Buffers Commands

" ds_, cs_, ys(obj)_
Plug 'tpope/vim-surround'

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"" Aesthetics
Plug 'junegunn/goyo.vim'  " distraction free mode

"" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ayu-theme/ayu-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'sickill/vim-monokai'

"" Python
" Plug 'davidhalter/jedi-vim'  " has issues with hanging on completion
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

"" Scala
" Plug 'ensime/ensime-vim'
Plug 'derekwyatt/vim-scala'

"" Haskell
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
" let g:LanguageClient_serverCommands = { 'haskell': ['hie', '--lsp'] }

call plug#end()

colo monokai_pro
" http://vimgolf.com/
