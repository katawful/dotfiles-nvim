(module plugins.treesitter.rainbow.config {require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for TS-rainbow
;;; https://github.com/p00f/nvim-ts-rainbow

;; Setup -- setup table for rainbow
(opt- :nvim-treesitter.configs :setup
      {:rainbow {:enable true :extended_mode true :max_file_lines 1000}})
