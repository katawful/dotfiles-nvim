(module vimwiki
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.maps.macros]
         require {j plugins.jobs}})

(setl- shiftwidth 2)
(setl- tabstop 2)
(setl- listchars "tab:  ")
(setl- concealcursor :nc)

(nno- :<leader>U "<Cmd>lua require('j').lazyGitUpdate()<CR>" "Update git repo" {:buffer true})
