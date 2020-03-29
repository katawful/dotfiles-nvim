" sets line numbers and syntax
set number
syntax on
filetype indent plugin on
set modeline
set mouse=a

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

"UltiSnips
Plug 'SirVer/ultisnips'

call plug#end()

" set window title to neovim
set title
set titlestring=neovim
" NerdTree stuff
" autocmd vimenter * NERDTree
map <C-T> :NERDTreeToggle<CR>
" let g:NERDTreeWinPos = "right"

" Airline stuff
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"neovim-remote for latex
let g:vimtex_compiler_progname = 'nvr'

"vimtex settings
let g:vimtex_enabled = '1'
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_complete_close_braces = '1'
let g:vimtex_quickfix_mode = '0'
let conceallevel = '1'
let g:tex_conceal = 'abdmg'

"ultisnips settings
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" copy to clipboard when yanking
set clipboard+=unnamedplus

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
