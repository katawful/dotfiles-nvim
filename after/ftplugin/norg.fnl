(module neorg {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

(setl- tabstop 2)
(setl- shiftwidth 2)
(setl- listchars "tab:  ,extends:>,precedes:<")
(setl- wrap false)
(setl- foldexpr "nvim_treesitter#foldexpr()")
(setl- foldmethod :expr)
