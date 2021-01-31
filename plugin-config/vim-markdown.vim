let g:vim_markdown_frontmatter = 1
augroup ft_markdown
	autocmd!
	autocmd FileType markdown set conceallevel=0
	autocmd FileType markdown setlocal spell
augroup END
