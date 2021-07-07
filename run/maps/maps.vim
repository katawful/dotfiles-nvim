" remap : for commands to ;
nnoremap ; :
nnoremap : ;

" y$ copies to the right from the cursor
nnoremap Y y$

" <C-x> <C-u> is for completefunc user complete
inoremap <C-u> <C-x><C-u>

" map H, J, K, L to more useful bindings
nnoremap H g^
nnoremap J }
nnoremap K {
nnoremap L g_
vnoremap H g^
vnoremap J }
vnoremap K {
vnoremap L g_

" delete line in insert mode (cause I keep entering too early)
inoremap <C-BS> <Esc>dda

" backspace for <C-o> controls
nnoremap <BS> <C-o>
nnoremap <C-BS> <C-i>

" closing mappings
" inoremap <expr> ) matchstr(getline('.'), '\%' . col('.') . 'c.') == ')' ? '<Right>' : ')'
" inoremap <expr> ] matchstr(getline('.'), '\%' . col('.') . 'c.') == ']' ? '<Right>' : ']'
" inoremap <expr> } matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<Right>' : '}'
" inoremap <expr> " matchstr(getline('.'), '\%' . col('.') . 'c.') == '"' ? '<Right>' : '""<Left>'
" inoremap <expr> ' matchstr(getline('.'), '\%' . col('.') . 'c.') == "'" ? '<Right>' : "''<Left>"
" inoremap <expr> <CR> matchstr(getline('.'), '\%' . col('.') . 'c.') == '}' ? '<CR><Up><Tab>' : '<CR>'
