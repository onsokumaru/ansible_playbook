"==========================================
" Name: Mike Furtado
" Date: 11-21-19
" File: .vimrc
" =========================================
"
" --- DEFAULT SETTINGS {{{
"
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"}}}

" --- CUSTOM SETTINGS {{{
"************************************
" ***** my additions to .vimrc *****
"************************************

" --- BASIC SETTINGS {{{
"colorscheme elflord

set laststatus=2 " for lightline
set ruler
set number		    "show line numbers
set tabstop=4 		"number of visual spaces per TAB
set softtabstop=4	"number of spaces in tab when editing
set expandtab		"tabs are spaces
set autoindent		"turns on auto indent
set shiftwidth=4	"indenting is 4 spaces ?
set cursorline		"highlight current line
filetype indent on	"load filetype-specific indent files
set wildmenu		"visual autocomplete for command menu
set showmatch		"highlight matching for [{()}]
"}}}

" --- SEARCH OPTIONS {{{
"*******************************
" ***** Searching Options *****
"*******************************

" incrementral search is enabled above
set hlsearch		"highlight matches

" turn off search highlight - otherwise it remains on until new search
nnoremap <leader><space> :nohlsearch<CR>
"}}}

" --- AUTO_CLOSING BRACKETS, ETC {{{
"*****************************************
" ***** Auto-closing brackets, etc. *****
"*****************************************
"
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
"}}}

" --- FOLDING OPTIONS {{{
"*****************************
" ***** Folding Options *****
"*****************************

set foldenable		"enable folding
"set foldlevelstart=10	"set fold level (0-99) - this opens most folds
"set foldnestmax=10	"set nested fold max to 10
"set foldmethod=indent	"fold based on indent level
set foldmethod=marker
" map space key to open and close folds
nnoremap <space> za
"}}}

" --- MOVEMENT OPTIONS {{{
"*******************************
" ***** Movemente Options *****
"*******************************

" hightlight last inserted text
nnoremap gV `[v`]
"}}}

" --- LEADER OPTIONS {{{
"****************************
" ***** Leader Options *****
"****************************
"
let mapleader=","	"map leader to comma

" map jk to escape to make it easier to jump to command mode
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" edit vimrc on the fly and load key bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

"save session
nnoremap <leader>s :mksession<CR>
"}}}

" --- TAB OPTIONS {{{
"*************************
" ***** Tab Options *****
"*************************

" remap tabedit to make it easier
nnoremap <leader>te :tabedit 
" remap tabclose to make it easier
nnoremap <leader>tt :tabclose<CR>
" remap tabclose to make it easier
nnoremap <leader>to :tabonly<CR>
"}}}

" --- ABBREVIATIONS {{{
"***************************
" ***** Abbreviations *****
"***************************

abbr _sh #!/bin/bash
abbr _pl #!/usr/bin/perl
abbr _py #!/usr/python3
"}}}

" --- PLUGIN INSTALLATION SECTION {{{
"************************************
" ***** Additions for Vim-Plug *****
"************************************

" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" add plugins to use below 
" use single quotes
"
" replace status line - https://github.com/itchyny/lightline.vim
Plug 'itchyny/lightline.vim'

" NERDTree - https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" PaleNight Color Scheme - https://github.com/drewtempelmeyer/palenight.vim
Plug 'drewtempelmeyer/palenight.vim'

" Vim - Git Gutter - 
Plug 'airblade/vim-gitgutter'

" UltiSnips https://https://github.com/SirVer/ultisnips
Plug 'sirver/UltiSnips'

" YouCompleteMe - https://github.com/ycm-core/YouCompleteMe
Plug 'ycm-core/YouCompleteMe'
call plug#end() 
"
"***************************
" ***** YouCompleteMe *****
"***************************
" ycm options can be written here
" 
" jump to function definition"
nnoremap <leader>] :YcmCompleter GoTo<CR> 
" increase vim-plug timeout for YCM
let g:plug_timeout = 300
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
"

"**********************
" ***** NERDTree *****
"**********************
" toggle NERDTree
map <C-o> :NERDTreeToggle<CR>

"***********************
" ***** UltiSnips *****
"***********************

" Trigger configuration. You need to change this to something else than <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"************************************
" ***** Palenight Color Scheme *****
"************************************

colorscheme palenight 

" configure lightline
"let g:lightline.colorscheme = 'palenight'

" configure True Colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
""if (has("termguicolors")) comment out for color in tmux
""  set termguicolors
""endif

""set laststatus=2
"}}}

"}}}
