setlocal tabstop=2
setlocal shiftwidth=2
let g:ov_sync_time= 1

" bracket mappings
inoremap <buffer> ( ()<Left>
inoremap <buffer> [ []<Left>
inoremap <buffer> { {}<Left>
" closing mappings
inoremap <buffer> <expr> ) matchstr(getline('.'), '\%' . col('.') . 'c.') == ')' ? '<Right>' : ')'
inoremap <buffer> <expr> ] matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' ? '<Right>' : ']'
inoremap <buffer> <expr> } matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<Right>' : '}'
inoremap <buffer> <expr> " matchstr(getline('.'), '\%' . col('.') . 'c.') == '"' ? '<Right>' : '""<Left>'
inoremap <buffer> <expr> ' matchstr(getline('.'), '\%' . col('.') . 'c.') == "'" ? '<Right>' : "''<Left>"
inoremap <buffer> <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Up><Right><CR>' : '<CR>'

nnoremap <buffer> <leader>U :call LazyGitUpdate()<CR>
