"" Leader
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
"" Main settings
syntax on
filetype plugin indent on
set foldmethod=syntax
set nocompatible
set modeline
set mouse=a
set relativenumber

set updatetime=100
set cmdheight=2
set list lcs=tab:\|\ 
set clipboard+=unnamedplus

set title
set inccommand=nosplit
autocmd BufEnter * let &titlestring = " " . expand("%:t")

"" autocommands
autocmd FileType text setlocal spell
