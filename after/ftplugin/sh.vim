setlocal tabstop=2
setlocal shiftwidth=2

" bracket mappings
inoremap <buffer> ( ()<Left>
inoremap <buffer> [ []<Left>
inoremap <buffer> { {}<Left>
" closing mappings
inoremap <buffer> <expr> ) matchstr(getline('.'), '\%' . col('.') . 'c.') == ')' ? '<Right>' : ')'
inoremap <buffer> <expr> ] matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' ? '<Right>' : ']'
inoremap <buffer> <expr> } matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<Right>' : '}'
inoremap <buffer> <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Up><Right><CR>' : '<CR>'
