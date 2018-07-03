set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'taketwo/vim-ros'
Plugin 'fatih/vim-go'
Plugin 'sean-der/vim-clang-format'
Plugin 'mindriot101/vim-yapf'
Plugin 'aperezdc/vim-template'
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=0
set fo=cqt
set wrapmargin=0
set wrap
set nohls
set backspace=2
set wildmode=longest,list,full
set wildmenu

syntax enable

colorscheme delek
nmap <silent> <C-K> :wincmd k<CR>
nmap <silent> <C-J> :wincmd j<CR>
nmap <silent> <C-H> :wincmd h<CR>
nmap <silent> <C-L> :wincmd l<CR>

au BufNewFile,BufRead *.launch set filetype=xml
au BufNewFile,BufRead *.test set filetype=xml
au BufWinEnter * checktime

let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^'],
\ }
map <F9> :YcmCompleter FixIt<CR>
nnoremap <leader>goto :YcmCompleter GoTo<CR>
nnoremap <leader>type :YcmCompleter GetType<CR>
nnoremap <leader>doc :YcmCompleter GetDoc<CR>
let g:ycm_confirm_extra_conf = 0

let g:go_fmt_command = "goimports"
let g:clang_format#auto_format = 1

let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_liststyle = 0
let g:netrw_winsize = 15
let g:netrw_altv = 1
