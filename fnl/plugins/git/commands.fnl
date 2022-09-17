(module plugins.git.commands
        {require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;;; Commands for git

(defn lazy-update [] (do-command Git "add -u")
      (do-command Git "commit -m 'update'") (do-command Git :push))
