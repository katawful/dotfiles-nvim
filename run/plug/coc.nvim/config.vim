" enable for file types
augroup ft_coc
  autocmd!
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd FileType text,wiki,tex let b:coc_suggest_disable = 1
augroup END
