" terminal settings {{{
augroup ft_terminal
  autocmd!
  autocmd TermOpen * setlocal nonumber
  autocmd TermOpen * setlocal relativenumber!
  autocmd TermOpen * setlocal nospell
  autocmd TermOpen * setlocal bufhidden=hide
augroup END
" }}}
