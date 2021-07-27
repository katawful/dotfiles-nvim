(module vimwiki
        {require-macros [macros]
         require {j plugins.jobs}})

(setl- shiftwidth 2)
(setl- tabstop 2)
(setl- listchars "tab:  ")
(setl- concealcursor :nc)

(nno- :<leader>U "<Cmd>lua require('j').lazyGitUpdate()<CR>" :buffer)
