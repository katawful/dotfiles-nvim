(module plugins.git.commands
        {require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;;; Commands for git

(defn lazy-update [] (com- Git "add -u") (com- Git "commit -m 'update'")
      (com- Git push))
