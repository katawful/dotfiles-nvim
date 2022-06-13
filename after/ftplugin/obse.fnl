(module obse
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.maps.macros]
         require {b plugins.closeBracket}})

(setl- tabstop 2)
(setl- shiftwidth 2)
(let- g :ov_sync_time 1)
(let- g :ov_window_style :double)
; (nno- :<LocalLeader>s :caw :buffer)

; enclose word
(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

; comes from plugins.closeBracket
(ino- ")" "v:lua.paren()" {:buffer true
                           :expr true})
(ino- "]" "v:lua.bracket()" {:buffer true
                             :expr true})
(ino- "}" "v:lua.brace()" {:buffer true
                           :expr true})
