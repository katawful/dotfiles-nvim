(module plugins.session.maps
  {autoload {sessions plugins.session.init
             save plugins.session.save
             fzf plugins.fzf.launchers
             au plugins.session.au}
   require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for sessions

;; String -- session leader subkey
(defonce session-leader "<leader>k")

(nno- (.. session-leader :s) (fn []
                               (set save.handles.save-on-hold false)
                               (set save.handles.save? true)
                               (au.cursor-hold)
                               (save.save! true))
      "Save a session, getting rid of autosave")

(nno- (.. session-leader :a) (fn []
                               (set save.handles.save-on-hold true)
                               (set save.handles.save? true)
                               (au.cursor-hold)
                               (save.save!))
      "Save a session, starting autosave")

(nno- (.. session-leader :f) (fn []
                               (fzf.search-sessions))
      "Search sessions with fzf")
