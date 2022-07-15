(module plugins.session.commands
        {autoload {session plugins.session.init
                   save plugins.session.save
                   au plugins.session.au
                   util plugins.session.utils
                   fzf plugins.fzf.launchers}
         require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

(command- :KatSessionCreate
          (fn []
            (session.create! (util.generate$))) "Create a session")

(command- :KatSessionSearch
          (fn []
            (fzf.search-sessions)) "Search through sessions")

(command- :KatSessionLoad
          (fn [args]
            (session.load<-name args.args)) {:nargs 1})

(command- :KatSessionSave (fn [args]
                            (match args.args
                              :autosave (do
                                          (set save.handles.save? true)
                                          (set save.handles.save-on-hold true))
                              _ (do
                                  (set save.handles.save-on-hold false)
                                  (set save.handles.save? true)))
                            (au.cursor-hold)
                            (save.save! true))
          "Save a session, create if not found. Arg option 'autosave'"
          {:nargs "?"})
