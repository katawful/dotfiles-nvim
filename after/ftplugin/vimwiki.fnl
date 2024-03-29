(module vimwiki {require-macros [katcros-fnl.macros.nvim.api.options.macros
                                 katcros-fnl.macros.nvim.api.maps.macros]
                 autoload {git-command plugins.git.commands}})

(set-opts-auto {shiftwidth 2 tabstop 2 listchars {:tab "  "} concealcursor :nc})

(nno- :<leader>U (fn []
                   (git-command.lazy-update))
      "Update git repo" {:buffer true})
