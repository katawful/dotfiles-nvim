call plug#begin('~/.local/share/nvim/plug')

"Fugitive Vim Github Wrapper
Plug 'tpope/vim-fugitive'
"Airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
"VimTeX
Plug 'lervag/vimtex'
" UltiSnips
Plug 'SirVer/ultisnips'
" Vimwiki
Plug 'vimwiki/vimwiki'
" vim-devicons
Plug 'ryanoasis/vim-devicons'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" vim-startify
Plug 'mhinz/vim-startify'
" vim-markdown
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'
" vim-liquid
" Plug 'tpope/vim-liquid'
" indentLine
Plug 'Yggdroot/indentLine'
" vim-openscad
Plug 'sirtaj/vim-openscad'
" Cxx highlight
Plug 'jackguo380/vim-lsp-cxx-highlight'
" vim-print-debug
Plug 'sentriz/vim-print-debug'
" vim commentary
Plug 'tpope/vim-commentary'
" Obli-Vim
Plug 'katawful/Obli-Vim', {'for': 'obse'}
Plug 'katawful/Obli-Vim-Docs', {'for': 'obse'}
" calendar.vim
Plug 'mattn/calendar-vim'
" kat.vim
Plug 'katawful/kat.vim'
" lightline
" Plug 'itchyny/lightline.vim'
" fennel.vim
Plug 'bakpakin/fennel.vim'
" nvim-lspconfig
Plug 'neovim/nvim-lspconfig'
" nvim-tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" tree-sitter playground
Plug 'nvim-treesitter/playground'
" Aniseed
Plug 'Olical/aniseed'
" lualine
Plug 'hoob3rt/lualine.nvim'
" nvim web devicons
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" nvim bufferline
Plug 'akinsho/nvim-bufferline.lua'


call plug#end()
lua require'bufferline'.setup()

let g:plug_url_format = "git@github.com:%s.git"
let g:aniseed#env = v:true

" add my runtime
" runtime! run/*.vim
" runtime! run/**/*.vim
