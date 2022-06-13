(module indentline
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

(let- g :indent_blankline_use_treesitter true)
(let- g :indent_blankline_show_current_context true)
(let- g :indent_blankline_filetype_exclude [:text
                                            :terminal
                                            :startify
                                            :help
                                            :calendar
                                            :startup
                                            :norg])
                                            
(let- g :indent_blankline_buftype_exclude [:terminal])
