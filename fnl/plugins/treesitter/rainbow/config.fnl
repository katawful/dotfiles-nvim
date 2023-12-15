(module plugins.treesitter.rainbow.config
        {autoload {rainbow ts-rainbow}
         require-macros [katcros-fnl.macros.lispism.macros]})

;;; Configs for TS-rainbow
;;; https://github.com/p00f/nvim-ts-rainbow

;; Setup -- setup table for rainbow
(opt- :nvim-treesitter.configs :setup
      {:rainbow {:enable true :strategy rainbow.strategy.global
                 :queries {1 :rainbow-parens
                           :fennel :rainbow-parens
                           :html :rainbow-tags
                           :latex :rainbow-blocks}}})
