(module plugins.treesitter.docs.config {require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for nvim-tree-docs
;;; https://github.com/nvim-treesitter/nvim-tree-docs

;; Setup -- setup table for tree-docs
(opt- :nvim-treesitter.configs :setup {:tree_docs {:enable false}})
