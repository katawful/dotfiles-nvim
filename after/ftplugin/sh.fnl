(module sh {require-macros [katcros-fnl.macros.nvim.api.options.macros
                            katcros-fnl.macros.nvim.api.maps.macros]
            autoload {autoclose plugins.insert.autoclose
                      indent plugins.insert.indent}})

(set-opts-auto {tabstop 2 shiftwidth 2})

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
