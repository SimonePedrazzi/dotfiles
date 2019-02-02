"  ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================


call plug#begin('~/.config/nvim/plugged')

" Common
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'							" Status line at the bottom
Plug 'Townk/vim-autoclose'							" Automatically close parenthesis, etc
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'

" Language Support
Plug 'lifepillar/pgsql.vim'							" PostgreSQL syntax highlighting
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins', 'for': 'python' } 	" Python autocomplete
Plug 'davidhalter/jedi-vim', { 'for': 'python' }  				" Python goto etc
Plug 'tmhedberg/SimpylFold'         						" Python folding
Plug 'sheerun/vim-polyglot'							" Better language packs

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'           						" CtrlP is installed to support tag finding in vim-go

call plug#end()


" -------------------------------------------------------------------------
" ---- GENERAL
" -------------------------------------------------------------------------

set shell=/bin/bash
set encoding=UTF-8

let g:python3_host_prog = $HOME . '/.pyenv/versions/3.7.2/envs/neovim3/bin/python'
let g:python_host_prog = $HOME . '/.pyenv/versions/2.7.15/envs/neovim2/bin/python'


let mapleader = ','

set autoindent                    " take indent for new line from previous line
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set completeopt-=preview          " remove the horrendous preview window
set cursorline                    " highlight the current line for the cursor
set noerrorbells                  " No bells!
set noswapfile                    " disable swapfile usage
set novisualbell                  " I said, no bells!
set smartindent                   " enable smart indentation
set number			  " Display line numbers
set ruler			  " Display cursor position
set ignorecase			  " Ignore case in vim searches

" Fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" Enable mouse if possible
if has('mouse')
    set mouse=a
endif


" yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


"----------------------------------------------
" General Python stuff
"----------------------------------------------
" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e


"----------------------------------------------
" Plugin: Deoplete
"----------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1

" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction
function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction


"----------------------------------------------
" Plugin: Jedi-vim
"----------------------------------------------
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>


"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>


"----------------------------------------------
" Plugin: 'scrooloose/nerdtree'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).

" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.pyc$', '^__pycache__$', 'egg-info$']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

noremap <leader>t :NERDTreeToggle<CR>

" Autoopen NERDTree when nvim starts up
autocmd vimenter * NERDTree	
" Auto close NERDTree if only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"----------------------------------------------
" Plugin: 'w0rp/ale'
"----------------------------------------------
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_python_flake8_options = '--max-line-length=100'
let g:ale_python_pylint_options = '--max-line-length=100 --no-docstring-rgx=test'
let g:ale_linters = {
\    'javascript': ['eslint'],
\    'python': ['flake8']
\}


"----------------------------------------------
" Plugin: 'tmhedberg/SimpylFold'
"----------------------------------------------
let g:SimpylFold_docstring_preview	= 0
let g:SimpylFold_fold_docstring		= 1
let b:SimpylFold_fold_docstring		= 1
let g:SimpylFold_fold_import		= 0
let b:SimpylFold_fold_import		= 0


"----------------------------------------------
" Plugin: 'ctrlpvim/ctrlp.vim'
"----------------------------------------------
" Note: We are not using CtrlP much in this configuration. But vim-go depend on
" it to run GoDecls(Dir).

" Disable the CtrlP mapping, since we want to use FZF instead for <c-p>.
let g:ctrlp_map = ''


"----------------------------------------------
" Plugin: 'junegunn/fzf.vim'
"----------------------------------------------
nnoremap <c-p> :FZF<cr>


"----------------------------------------------
" Plugin: 'sheerun/vim-polyglot'
"----------------------------------------------
let g:polyglot_disabled = ['md', 'markdown']


"----------------------------------------------
" Plugin: 'NLKNguyen/papercolor-theme'
"----------------------------------------------
set background=dark
colorscheme PaperColor


"----------------------------------------------
" Plugin: 'bling/vim-airline'
"----------------------------------------------
let g:airline_theme = 'dark'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1
