(module plugins.cmp.config
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for nvim-cmp
;;; https://github.com/hrsh7th/nvim-cmp

(def- cmp (require :cmp))
(set-opt completeopt "menu,menuone,noselect")
(cmp.setup {:sources (cmp.config.sources {1 {:name :neorg}} {1 {:name :buffer}})})
