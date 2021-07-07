setlocal listchars=tab:\ \ 
setlocal shiftwidth=2
setlocal tabstop=2
setlocal concealcursor=nc

" Vimwiki syntax changes
" if has("gui_running") || has('nvim-0.4')
"   hi def VimwikiDelText ctermfg=1 term=strikethrough cterm=strikethrough gui=strikethrough
" endif

" hi def link VimwikiMarkers Special
" hi VimwikiHeader cterm=bold term=bold gui=bold
" hi VimwikiLink cterm=underline ctermfg=3 term=underline
" hi VimwikiListTodo ctermfg=14 cterm=bold
" hi VimwikiCode ctermfg=5
" syn match VimwikiListTodoQuestion "/\* \[?\]" contained
" hi def link VimwikiListTodoQuestion VimwikiListTodo

nnoremap <leader>U :call LazyGitUpdate()<CR>
