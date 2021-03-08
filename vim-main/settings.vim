"" Leader {{{
nnoremap <Space> <Nop>
let mapleader = "\<Space>"
" }}}
"" Main settings {{{
syntax on
filetype plugin indent on
set foldmethod=syntax
set modeline
set mouse=a
set relativenumber
set number

set updatetime=100
set cmdheight=2
" set list lcs=tab:\|\ 
set list
set listchars=tab:\ \ ,trail:■,extends:>,precedes:<
set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=2
set expandtab
set conceallevel=2

set title
set inccommand=nosplit
colorscheme kat
" Title window, broke otherwise {{{
augroup title
	autocmd!
	autocmd BufEnter * let &titlestring = "NeoVim: " . expand("%:t")
augroup END
" }}}
" }}}

"" AutoCommands {{{
" text settings {{{
augroup ft_text
	autocmd!
	autocmd FileType text setlocal spell
augroup END
" }}}

" OBSE settings {{{
augroup ft_obse
	autocmd!
	autocmd FileType obse setlocal tabstop=4
augroup END
" }}}

" Vimscript settings {{{
augroup ft_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" }}}
