set omnifunc=syntaxcomplete#Complete
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
inoremap <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Tab>' : '<CR>'
