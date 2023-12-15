(module plugins.markid.config
         {require-macros [katcros-fnl.macros.lispism.macros]})

(local m (require :markid))

(opt- :nvim-treesitter.configs :setup
      {:markid {:enable true
                :colors m.colors.medium
                :queries m.queries}})

(tset m.queries :fennel
      "(symbol) @markid")
