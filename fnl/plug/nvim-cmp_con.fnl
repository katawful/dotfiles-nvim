(module nvim-cmp_con
        {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

(def- cmp (require :cmp))
(set- completeopt "menu,menuone,noselect")
(cmp.setup {:sources (cmp.config.sources {1 {:name :neorg}} {1 {:name :buffer}})})
