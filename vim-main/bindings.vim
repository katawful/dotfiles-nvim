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
inoremap <C-u> <C-x><C-u>

" buffer searching
nnoremap <leader>g :g//#<Left><Left>

" align columns in visual mode
vnoremap <leader>a :'<,'>!column -t<CR>

"" Window Movement
" decrease width
nnoremap <C-H> <C-W><
" increase width
nnoremap <C-L> <C-W>>
" decrease height
nnoremap <C-K> <C-W>-
" increase height
nnoremap <C-J> <C-W>+
" easier <C-w>
nnoremap <leader>w <C-w>

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

" move window in normal/terminal modes
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l


" go back to normal mode from terminal
tnoremap <C-Space> <C-\><C-N>

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

" comment out lines in visual mode
vnoremap <leader>; :s/^/;<CR>:let @/ = "" <CR>
vnoremap <leader># :s/^/#<CR>:let @/ = "" <CR>
vnoremap <leader>/ :s/^/\/\/<CR>:let @/ = "" <CR>

" delete line in insert mode (cause I keep entering too early)
inoremap <C-BS> <Esc>dda
