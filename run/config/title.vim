set title
" Title window, broke otherwise
augroup title
	autocmd!
	" autocmd BufEnter * let &titlestring = "NeoVim: " . expand("%:t")
augroup END
