(module plugins.goyo.config
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

;;; Configs for Goyo
;;; https://github.com/junegunn/goyo.vim

(set-var g :goyo_width 120)

;; Call maps
(require :plugins.goyo.maps)
