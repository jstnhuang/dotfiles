set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dense-analysis/ale'
call vundle#end()            " required
filetype plugin indent on    " required

set scrolloff=10
set ignorecase
set smartcase
set incsearch
set showmatch
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
set fo=cqt
set wrapmargin=0
set wrap
set nohls
set backspace=2
set wildmode=longest,list,full
set wildmenu
set cursorline

syntax enable

set background=dark

let g:zenburn_transparent=1
colorscheme zenburn
nmap <silent> <C-K> :wincmd k<CR>
nmap <silent> <C-J> :wincmd j<CR>
nmap <silent> <C-H> :wincmd h<CR>
nmap <silent> <C-L> :wincmd l<CR>

au BufWinEnter * checktime
au BufNewFile,BufRead *.py cc=89
au BufNewFile,BufRead *.cc cc=81
au BufNewFile,BufRead *.cpp cc=81

map <F9> :YcmCompleter FixIt<CR>
nnoremap <leader>goto :YcmCompleter GoTo<CR>
nnoremap <leader>def :YcmCompleter GoToDefinition<CR>
nnoremap <leader>include :YcmCompleter GoToInclude<CR>
nnoremap <leader>type :YcmCompleter GetType<CR>
nnoremap <leader>doc :YcmCompleter GetDoc<CR>

let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_liststyle = 0
let g:netrw_winsize = 25
let g:netrw_altv = 1

let g:ale_fixers = {
\ 'cpp': ['clang-format'],
\ 'css': ['prettier'],
\ 'html': ['prettier'],
\ 'javascript': ['prettier'],
\ 'python': ['black'],
\ 'proto': ['clang-format'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\}
let g:ale_fix_on_save=1
let g:ale_linters={
\ 'cpp': [],
\ 'python': ['flake8', 'mypy']
\}
