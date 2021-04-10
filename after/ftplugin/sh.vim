setlocal tabstop=2
setlocal shiftwidth=2

" bracket mappings
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
" closing mappings
inoremap <expr> ) matchstr(getline('.'), '\%' . col('.') . 'c.') == ')' ? '<Right>' : ')'
inoremap <expr> ] matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' ? '<Right>' : ']'
inoremap <expr> } matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<Right>' : '}'
inoremap <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Up><Tab>' : '<CR>'
