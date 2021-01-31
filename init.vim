call plug#begin('~/.local/share/vim-plug')

"Fugitive Vim Github Wrapper
Plug 'tpope/vim-fugitive'
"NerdTree
Plug 'preservim/nerdtree'
"Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"VimTeX
Plug 'lervag/vimtex'
" Vim latex live prwview
Plug 'xuhdev/vim-latex-live-preview'
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
Plug 'katawful/Obli-Vim', {'for': 'obse', 'branch': 'cse-plugin'}
Plug 'katawful/Obli-Vim-Docs', {'for': 'obse'}

call plug#end()

"" Settings
source ~/vim-main/settings.vim
"" Bindings
source ~/vim-main/bindings.vim
"" Functions
source ~/vim-main/functions.vim
"" Airline
source ~/plugin-config/airline.vim
"" FZF/fzf.vim
source ~/plugin-config/fzf.vim
"" NerdTree
source ~/plugin-config/nerdtree.vim
"" LaTeX
source ~/plugin-config/latex.vim
"" UltiSnips
source ~/plugin-config/ultisnips.vim
"" Vimwiki
source ~/plugin-config/vimwiki.vim
"" coc.nvim
source ~/plugin-config/coc.vim
"" startify
source ~/plugin-config/startify.vim
"" vim-markdown
source ~/plugin-config/vim-markdown.vim
"" indentLine
source ~/plugin-config/indentline.vim
"" vim-print-debug
source ~/plugin-config/print-debug.vim
