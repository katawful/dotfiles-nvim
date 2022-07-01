(module plugins.startify.commands
        {autoload {configs plugins.startify.config}
         require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;;; User commands for startify

(command- :KatStart
          (fn []
            (configs.update-variables)
            ((. vim.fn "startify#insane_in_the_membrane") 0 1))
          "Open a Startify window with fresh vars")
