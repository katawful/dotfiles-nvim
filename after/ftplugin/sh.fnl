(module sh
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.maps.macros]
         autoload {autoclose plugins.insert.autoclose
                   indent plugins.insert.indent}})

(setl- tabstop 2)
(setl- shiftwidth 2)

; ; enclose word
(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

(ino- ")" (fn [] (autoclose.paren)) {:buffer true :expr true})

(ino- "]" (fn [] (autoclose.bracket)) {:buffer true :expr true})

(ino- "}" (fn [] (autoclose.brace)) {:buffer true :expr true})

(ino- :<CR> (fn [] (indent.curly)) {:buffer true :expr true})
