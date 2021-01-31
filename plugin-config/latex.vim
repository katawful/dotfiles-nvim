"" NOTE
" This combines the settings for neovim-remote, Vimtex, and vim-latex-preview
"
"" neovim-remote for latex
let g:vimtex_compiler_progname = 'nvr'
"" vimtex settings
let g:vimtex_compiler_latexmk = { 
        \ 'executable' : 'latexmk',
        \ 'options' : [ 
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_enabled = '1'
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_complete_close_braces = '1'
let g:vimtex_quickfix_mode = '0'
let conceallevel = '1'
let g:tex_conceal = 'abdmg'
augroup ft_tex
	autocmd!
	au FileType tex setlocal spell
	au FileType tex nnoremap <leader>O :VimtexCompileOutput<CR>
	au FileType tex nnoremap <leader>C :VimtexCompile<CR>
	au FileType tex nnoremap <leader>V :VimtexView<CR>
augroup END
"" vim latex preview
let g:livepreview_previewer = 'zathura'
