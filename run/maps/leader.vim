" copy whole buffer to clipboard
nnoremap <leader>y :%y<CR>
" buffer searching
nnoremap <leader>g :g//#<Left><Left>
" align columns in visual mode
vnoremap <leader>a :'<,'>!column -t<CR>
