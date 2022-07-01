(module plugins.tabby.config)

;;; Configs for tabby.nvim
;;; https://github.com/nanozuki/tabby.nvim

;; Setup -- setup table for tabby
((. (require :tabby) :setup) {:tabline (. (require :tabby.presets)
                                          :active_wins_at_tail)})
