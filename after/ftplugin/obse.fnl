(module obse {require-macros [katcros-fnl.macros.nvim.api.options.macros
                              katcros-fnl.macros.nvim.api.maps.macros]
              autoload {autoclose plugins.insert.autoclose}})

(set-opts-auto {tabstop 2 shiftwidth 2})

(let- g :ov_sync_time 1)
(let- g :ov_window_style :double)
; (nno- :<LocalLeader>s :caw :buffer)

; enclose word
(ino- "(" "()<Left>" {:buffer true})
(ino- "[" "[]<Left>" {:buffer true})
(ino- "{" "{}<Left>" {:buffer true})

(ino- ")" (fn []
            (autoclose.parenthesis)) {:buffer true :expr true})

(ino- "]" (fn []
            (autoclose.bracket)) {:buffer true :expr true})

(ino- "}" (fn []
            (autoclose.brace)) {:buffer true :expr true})
