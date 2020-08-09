"" NOTE
" This combines the settings for neovim-remote, Vimtex, and vim-latex-preview
"
"" neovim-remote for latex
let g:vimtex_compiler_progname = 'nvr'
"" vimtex settings
let g:vimtex_enabled = '1'
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_complete_close_braces = '1'
let g:vimtex_quickfix_mode = '0'
let conceallevel = '1'
let g:tex_conceal = 'abdmg'
au FileType tex setlocal spell
"" vim latex preview
let g:livepreview_previewer = 'zathura'
