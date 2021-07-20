(module indentline
        {require-macros [macros]})

(let- g :indent_blankline_use_treesitter true)
(let- g :indent_blankline_show_current_context true)
(let- g :indent_blankline_filetype_exclude {1 :text
                                            2 :terminal
                                            3 :startify
                                            4 :help})
