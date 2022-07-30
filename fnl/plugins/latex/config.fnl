(module plugins.latex.config
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for latex

; set for neovim-remote
(set-vars g {:vimtex_compiler_progname :nvr
             :vimtex_compiler_method :latexmk
             :vimtex_enabled 1
             :vimtex_quickfix_mode 0
             :tex_flavor :latex
             :vimtex_view_general_viewer :zathura
             :vimtex_complete_close_braces 1
             :vimtex_quickfix-mode 1
             :tex_conceal :abdmg
             :vimtex_compiler_latexmk {:executable :latexmk
                                       :options [:-xelatex
                                                 :-file-line-error
                                                 :-synctex=1
                                                 :-interaction=nonstopmode]}})
