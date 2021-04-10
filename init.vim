call plug#begin('~/.local/share/nvim/plug')

"Fugitive Vim Github Wrapper
Plug 'tpope/vim-fugitive'
"NerdTree
Plug 'preservim/nerdtree'
"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vim-startify
Plug 'mhinz/vim-startify'
" vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
" vim-liquid
Plug 'tpope/vim-liquid'
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
" coc.nvim lua
Plug 'rafcamlet/coc-nvim-lua'
" Obli-Vim
Plug 'katawful/Obli-Vim', {'for': 'obse'}
Plug 'katawful/Obli-Vim-Docs', {'for': 'obse'}
" calendar.vim
Plug 'mattn/calendar-vim'

call plug#end()

" add my runtime
runtime! run/*.vim
runtime! run/**/*.vim
