(module neorg {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

(set-opts-auto {tabstop 2
                shiftwidth 2
                expandtab true
                textwidth 100
                spell true
                listchars {:tab "  " :extends ">" :precedes "<"}
                wrap false
                concealcursor :nvc})
