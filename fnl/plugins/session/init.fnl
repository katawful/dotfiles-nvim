(module plugins.session.init
  {autoload {store plugins.session.store.init
             util plugins.session.utils
             a aniseed.core}})

;;; Primary session management

;; String -- actual session file name
(defonce session-file ".katsession.vim")

(defn write! [session]
  (let [file (.. "." session.dir session-file)]
    (vim.cmd (.. "mksession! " file))))

(defn delete! [session]
  (let [new-session session
        file (.. "." session.dir session-file)]
    (set new-session.mark :delete)
    (store.file! (-> new-session (store.update) (a.str)))
    (os.remove file)))

(defn load! [session] "Load a session file"
  (let [file (.. "." session.dir session-file)]
    (if (= (vim.fn.filereadable file) 1)
      (do
        (vim.cmd (.. "source " file))
        (vim.notify (.. "Loading session: '" session.name "' in cwd: " session.dir)))
      (vim.notify (.. "Session file for '" session.name "' not found")
                  vim.log.levels.ERROR))))

(defn create! [session] "Creates a new session, stores it and writes the session file"
  (let [sessions (-> session (store.update) (a.str))]
    (store.file! sessions)
    (write! session)))

(require :plugins.session.commands)
