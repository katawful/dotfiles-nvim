(module nvim-cmp_con
        {require-macros [macros]})

(def- cmp (require :cmp))
(set- completeopt "menu,menuone,noselect")
(cmp.setup {:sources (cmp.config.sources {1 {:name :neorg}}
                                         {1 {:name :buffer}})})
