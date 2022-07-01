(module plugins.treesitter.context.config
        {require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for treesitter context
;;; https://github.com/nvim-treesitter/nvim-treesitter-context

;; Setup -- setup table for treesitter-context
(opt- :treesitter-context :setup {:enable true})
