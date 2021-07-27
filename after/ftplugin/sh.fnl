(module sh
        {require-macros [macros]
         require {b plugins.closeBracket}})

(setl- tabstop 2)
(setl- shiftwidth 2)

; ; enclose word
(ino- "(" "()<Left>" :buffer)
(ino- "[" "[]<Left>" :buffer)
(ino- "{" "{}<Left>" :buffer)

; comes from plugins.closeBracket
(ino- ")" "v:lua.paren()" :buffer :expr)
(ino- "]" "v:lua.bracket()" :buffer :expr)
(ino- "}" "v:lua.brace()" :buffer :expr)
