(module plugins.session.commands
        {autoload {session plugins.session.init
                   util plugins.session.utils
                   fzf plugins.fzf.launchers}
         require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

(command- :KatSessionCreate
          (fn []
            (session.create! (util.generate$))) "Create a session")

(command- :KatSessionSearch
          (fn []
            (fzf.search-sessions)) "Search through sessions")
