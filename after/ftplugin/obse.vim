setlocal tabstop=2
setlocal shiftwidth=2
let g:ov_sync_time= 1

" bracket mappings
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
" closing mappings
inoremap <expr> ) matchstr(getline('.'), '\%' . col('.') . 'c.') == ')' ? '<Right>' : ')'
inoremap <expr> ] matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' ? '<Right>' : ']'
inoremap <expr> } matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<Right>' : '}'
inoremap <expr> " matchstr(getline('.'), '\%' . col('.') . 'c.') == '"' ? '<Right>' : '""<Left>'
inoremap <expr> ' matchstr(getline('.'), '\%' . col('.') . 'c.') == "'" ? '<Right>' : "''<Left>"
inoremap <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Up><Tab>' : '<CR>'

nnoremap <leader>U :call LazyGitUpdate()<CR>
