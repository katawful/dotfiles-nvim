(module vimwiki {require-macros [katcros-fnl.macros.nvim.api.options.macros
                                 katcros-fnl.macros.nvim.api.maps.macros]
                 autoload {git-command plugins.git.commands}})

(setl- shiftwidth 2)
(setl- tabstop 2)
(setl- listchars "tab:  ")
(setl- concealcursor :nc)

(nno- :<leader>U (fn [] (git-command.lazy-update)) "Update git repo"
      {:buffer true})
