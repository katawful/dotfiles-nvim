syntax on
filetype plugin indent on
set foldmethod=syntax
set modeline
set mouse=a
set relativenumber
set number

set updatetime=100
set cmdheight=2
set list
set listchars=tab:\ \ ,trail:■,extends:>,precedes:<
set clipboard+=unnamedplus
set tabstop=2
set shiftwidth=2
set expandtab
set conceallevel=2
set linebreak
set breakindent
set showbreak==>

set inccommand=nosplit
colorscheme kat
set guifont=FiraCode\ Nerd\ Font:h15,\ MesloLGS\ NF:h15,DejavuSans:h15

augroup TextYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=150}
augroup END
