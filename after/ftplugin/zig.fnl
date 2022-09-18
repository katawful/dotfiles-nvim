(module zig
        {autoload {autoclose plugins.insert.autoclose
                   indent plugins.insert.indent}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

(set-local-opts {shiftwidth 4 tabstop 4})

(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

(ino- ")" (fn []
            (autoclose.parenthesis)) {:buffer true :expr true})

(ino- "]" (fn []
            (autoclose.bracket)) {:buffer true :expr true})

(ino- "}" (fn []
            (autoclose.brace)) {:buffer true :expr true})

(ino- "|" (fn []
            (autoclose.bar)) {:buffer true :expr true})

(ino- :<CR> (fn []
              (indent.curly)) {:buffer true :expr true})

(nno- :<F9> :<cmd>make<cr> "Run make")
