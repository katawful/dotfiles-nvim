(module indentline
        {require-macros [macros]})

(let- g :indentLine_char "|")
(let- g :indentLine_leadingSpaceChar ".")
(let- g :indentLine_showFirstIndentLevel 1)
(let- g :indentLine_setColors 1)
(let- g :indentLine_conceallevel 2)
(let- g :indentLine_concealcursor "nc")

(let- g :indentLine_fileTypeExclude {1 :text
                                     2 :help
                                     3 :startify
                                     4 :calendar})

; indent-blankline here cause i'm lazy
(let- g :indent_blankline_use_treesitter true)
(let- g :indent_blankline_show_current_context true)
