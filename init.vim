" sets line numbers and syntax
set number
syntax on
filetype indent plugin on
filetype plugin on
set foldmethod=syntax
set nocompatible
set modeline
set mouse=a
set title
autocmd BufEnter * let &titlestring = " " . expand("%:t")
autocmd BufEnter * colorscheme wal

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
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

"UltiSnips
Plug 'SirVer/ultisnips'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Vim wal theme
Plug 'dylanaraps/wal.vim'

" vim-devicons
Plug 'ryanoasis/vim-devicons'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" remap space to my leader
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" " fzf stuff
" Buffers
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>' :Marks<CR>

" NerdTree stuff
" autocmd vimenter * NERDTree
noremap <C-T> :NERDTreeToggle<CR>
" let g:NERDTreeWinPos = "right"

" Airline stuff
let g:airline_theme='bubblegum'
autocmd BufEnter * AirlineRefresh
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }
let g:airline_filetype_overrides = {
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ }

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
" vim latex preview
let g:livepreview_previewer = 'zathura'

"ultisnips settings
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" vimwiki stuff
let g:vimiwiki_folding = 'list'

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

" " my vim stuff
" remap : for commands to ;
nnoremap ; :
nnoremap : ;

" ciw clears a word and brings us to insert mode
nnoremap <leader>c ciw

" i<right> inserts to the right of the cursor for end of line inserts
nnoremap <leader>i i<Right>

" y$ copies to the right from the cursor
nnoremap Y y$

" copy whole buffer to clipboard
nnoremap <leader>y :%y<CR>

" <C-x> <C-u> is for completefunc user complete
inoremap <C-Space>u <C-x><C-u>

" move buffer next or previous
nnoremap <leader>bh :bprevious<CR>
nnoremap <leader>bl :bnext<CR>

" buffer searching
nnoremap <leader>g :g//#<Left><Left>

" align columns in visual mode
vnoremap <leader>a :'<,'>!column -t<CR>

" " window movement
" decrease width
nnoremap <C-H> <C-W><
" increase width
nnoremap <C-L> <C-W>>
" decrease height
nnoremap <C-K> <C-W>-
" increase height
nnoremap <C-J> <C-W>+

" tab in at beginning
nnoremap <C-Tab> 0i<tab><Esc>$

" go back to normal mode from terminal
tnoremap <C-Space> <C-\><C-N>

" enter terminal
nnoremap <leader>t :b<Tab>term

" from vim terminal help:
" this lets you move between windows in any mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" rename buffer (mostly for terminal)
nnoremap :rename :keepalt file

" move around in insert mode
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" move to end of line
inoremap <A-4> <End>

"move to beginning of line
inoremap <A-0> <Home>

" map to e, b, and w (a is needed for e and w for some reason)
inoremap <A-e> <Esc>ea
inoremap <A-b> <Esc>bi
inoremap <A-w> <Esc>wa

" map H, J, K, L to more useful bindings
nnoremap H 0
nnoremap J }
nnoremap K {
nnoremap L g_

" create windows using H, J, K, L
nnoremap <A-H> <C-w>v
nnoremap <A-J> <C-w>s<C-w>k
nnoremap <A-K> <C-w>s
nnoremap <A-L> <C-w>v<C-w>h
