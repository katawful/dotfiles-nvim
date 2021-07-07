(module vimtex
        {require-macros [macros]})

; set for neovim-remote
(let- g :vimtex_compiler_progname :nvr)

(let- g :vimtex_compiler_latexmk
  {1 {:executable :latexmk}
   2 {:options {1 "-xelatex"
                2 "-file-line-error"
                3 "-synctex=1"
                4 "-interaction=nonstopmode"}}})
(let- g :vimtex_compiler_method :latexmk)
(let- g :vimtex_enabled 1)
(let- g :tex_flavor :latex)
(let- g :vimtex_view_general_viewer :zathura)
(let- g :vimtex_complete_close_braces 1)
(let- g :vimtex_quickfix-mode 1)
(let- g :tex_conceal :abdmg)
