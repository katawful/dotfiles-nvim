(module plugins.session.au
  {autoload {save plugins.session.save
             session plugins.session.init}
   require-macros [katcros-fnl.macros.nvim.api.autocommands.macros]})

;;; Autocommands for session

(defn cursor-hold [] "Run cursorhold autocommand
If we want to stop autosaving, this makes sure to interrupt the timer
and set it to nil before doing so. Deletes augroup by name doing so."
  (if save.handles.save-on-hold
    (let [session-group (def-aug- "katSession")]
      (aug- session-group
            (auc- "CursorHold" "*"
                  (fn [] (save.cursor-hold))
                  "Session autosave process on cursor hold")))
    (do
      (vim.fn.timer_stop save.handles.init-save-timer)
      (set save.handles.init-save-timer nil)
      (vim.api.nvim_del_augroup_by_name "katSession"))))
