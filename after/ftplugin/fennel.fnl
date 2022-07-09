(module fennel-con {require-macros [katcros-fnl.macros.nvim.api.options.macros
                                    katcros-fnl.macros.nvim.api.maps.macros]
                    autoload {jump plugins.file.runners}})

; make button
(nno- :<F9> ":make!<CR>" "Run make")

;; <leader>jtt
(nno- jump.test-edit (fn []
                       (jump.->test :edit :-test.fnl))
      "Jump to aniseed test")

;; <leader>jtv
(nno- jump.test-vsplit
      (fn []
        (jump.->test :vsplit :-test.fnl))
      "Jump to aniseed test in a vsplit")

;; <leader>jts
(nno- jump.test-split (fn []
                        (jump.->test :split :-test.fnl))
      "Jump to aniseed test in a split")

;; <leader>jcc
(nno- jump.compile-edit
      (fn []
        (jump.->compiled :edit :lua :lua))
      "Jump to compiled fennel file in directory")

;; <leader>jcv
(nno- jump.compile-vsplit
      (fn []
        (jump.->compiled :vsplit :lua :lua))
      "Jump to compiled fennel file directory in vsplit")

;; <leader>jcs
(nno- jump.compile-split
      (fn []
        (jump.->compiled :split :lua :lua))
      "Jump to compiled fennel file in directory in split")

(setl- foldexpr "nvim_treesitter#foldexpr()")
(setl- foldmethod :expr)
