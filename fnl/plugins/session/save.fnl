(module plugins.session.save
        {autoload {session plugins.session.init
                   store plugins.session.store.init
                   json plugins.session.json
                   jump plugins.file.jump
                   util plugins.session.utils}
         require-macros [katcros-fnl.macros.nvim.api.autocommands.macros]})

;;; Save management

;; Key -- table to hold various save stuff
;; save-on-hold -- enable save on cursor hold?
;; save? -- do we want to save at all?
;; autosave-interval -- time, in seconds that autosaves should update
(def handles {:autosave-interval 180 :save-on-hold true :save? true})

(defn find [input] "Get session from loaded save, or make a new one
If a session with the current name is found, also check if there's a session
file. If so, just continue saving as is. If one isn't found, go through the
normal creation process" (jump.->root)
      (let [cur-dir (vim.loop.cwd)
            stored (-> (json.<-file)
                       (json.decode))
            stored-session []]
        (each [name tbl (pairs stored)]
          ;; gotta make sure that we are getting the right directory
          (let [dir (if (= (tbl.dir:sub -1) "/")
                        (tbl.dir:sub 1 -2)
                        tbl.dir)
                dir-tail (vim.fn.fnamemodify dir ":t")
                cur-dir-tail (vim.fn.fnamemodify cur-dir ":t")]
            (if (and (= dir cur-dir) (= dir-tail cur-dir-tail))
                (do
                  (tset stored-session 1 tbl)))))
        (if (?. stored-session 1)
            (if input
                (do
                  (vim.ui.input {:prompt "Describe the last thing you were doing: "}
                                (fn [input]
                                  (tset (. stored-session 1) :last input)))
                  (. stored-session 1))
                (. stored-session 1))
            (do
              (vim.ui.input {:prompt "Create a session to save? (y/N)"}
                            (fn [input]
                              (match input
                                :y (do
                                     (set handles.save? true)
                                     (set handles.save-on-hold true)
                                     (let [new-session (util.generate$)]
                                       (session.create! new-session)
                                       (tset stored-session 1 new-session)))
                                :n (do
                                     (set handles.save? false)
                                     (set handles.save-on-hold false)
                                     (tset stored-session 1 nil))
                                _ (do
                                    (set handles.save? false)
                                    (set handles.save-on-hold false)
                                    (tset stored-session 1 nil)))))
              (?. stored-session 1)))))

(defn save! [input] "Save a session, creating a new one if desired.
Important to note that this is dependent upon handles.save-on-hold.
This will usually only be set to false if I decline to create a new session during
the autosave process."
      (if (not (util.empty?))
          (let [session# (find input)]
            (when handles.save?
              (do
                (if input (session.create! session#) (session.write! session#))
                ;; the window from vim.notify was getting saved
                ;; simply run it later, it's not that important
                (vim.fn.timer_start 500
                                    (fn []
                                      (vim.notify (.. "Saving session '"
                                                      session#.name "'")))
                                    {:repeat 0}))))
          (vim.notify "Neovim is empty, not saving")))

(defn cursor-hold []
      "Process for how cursor hold should be run.
We need to check if we even have a session to save, creating one if no.
Use a predefined timer so we don't go through this with each hold.
Only start cursorhold process if we absolutely want to create a session save.
If we say no in this process, then we don't care about autosaving."
      ;; we do need save-on-hold to be *something*
      (if (= handles.save-on-hold nil)
          (set handles.save-on-hold true)
          ;; if save-on-hold true and init-save-timer is nil
          ;; basically we *do* want to save, but the timer is still going
          ;; just in case cursor-hold runs again
          (and handles.save-on-hold (not (?. handles :init-save-timer)))
          (do
            ;; only run this if we don't have a timer running for autosaves already
            (when handles.save-on-hold
              (do
                (set handles.init-save-timer
                     (vim.fn.timer_start (* handles.autosave-interval 1000)
                                         (fn []
                                           (save!)
                                           (vim.fn.timer_stop handles.init-save-timer)
                                           (set handles.init-save-timer nil))
                                         {:repeat 0})))))))
