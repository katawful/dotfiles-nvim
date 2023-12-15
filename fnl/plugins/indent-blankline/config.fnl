(module plugins.indent-blankline.config
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for indent_blankline
;;; https://github.com/lukas-reineke/indent-blankline.nvim

(set-vars g {:indent_blankline_use_treesitter true
             :indent_blankline_show_current_context true
             :indent_blankline_buftype_exclude [:terminal]
             :indent_blankline_filetype_exclude [:text
                                                 :terminal
                                                 :man
                                                 :NeogitPopup
                                                 :startify
                                                 :help
                                                 :calendar
                                                 :startup
                                                 :norg]})
