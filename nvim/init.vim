" lua require("nvim-tree-setup")

" Show line numbers
set number

" Syntax highlighting
filetype plugin on
" syntax on

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" set spell
:set spelllang=en_us
