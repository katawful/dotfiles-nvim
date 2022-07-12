(module lua {require-macros [katcros-fnl.macros.nvim.api.options.macros
                             katcros-fnl.macros.nvim.api.maps.macros]
             autoload {autoclose plugins.insert.autoclose
                       indent plugins.insert.indent
                       jump plugins.file.jump}})

; ; enclose word
(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

(ino- ")" (fn []
            (autoclose.parenthesis)) {:buffer true :expr true})

(ino- "]" (fn []
            (autoclose.bracket)) {:buffer true :expr true})

(ino- "}" (fn []
            (autoclose.brace)) {:buffer true :expr true})

(ino- :<CR> (fn []
              (indent.curly)) {:buffer true :expr true})

(setl- foldexpr "nvim_treesitter#foldexpr()")
(setl- foldmethod :expr)
(setl- ts 4)
(setl- sw 4)
(setg- expandtab true)

;; <leader>jcc
(nno- jump.compile-edit
      (fn []
        (jump.<-compiled :lua :fnl :fnl)) "Jump back to a source file")
