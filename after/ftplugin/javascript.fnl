(module javascript
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]
         require {b plugins.closeBracket i plugins.autoIndentCurly}})

; enclose word
(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

; comes from plugins.closeBracket
(ino- ")" "v:lua.paren()" {:buffer true :expr true})
(ino- "]" "v:lua.bracket()" {:buffer true :expr true})

(ino- "}" "v:lua.brace()" {:buffer true :expr true})

(ino- :<CR> "v:lua.indentCurly()" {:buffer true :expr true})
