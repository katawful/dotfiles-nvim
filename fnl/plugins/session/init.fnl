(module plugins.session.init
        {autoload {store plugins.session.store.init
                   util plugins.session.utils
                   json plugins.session.json
                   au plugins.session.au
                   a aniseed.core}})

;;; Primary session management

;; String -- actual session file name
(defonce session-file :.katsession.vim)

(defn write! [session]
      (let [file (.. session.dir "/" session-file)]
        (vim.schedule (fn []
                        (vim.cmd (.. "mksession! " file))))))

(defn delete! [session] (let [new-session session
                              file (.. session.dir "/" session-file)]
                          (set new-session.mark :delete)
                          (store.file! (store.update new-session))
                          (os.remove file)))

(defn load! [session] "Load a session file"
      (let [file (.. session.dir "/" session-file)]
        (if (= (vim.fn.filereadable file) 1)
            (do
              (vim.cmd (.. "silent! source " file))
              (vim.notify (.. "Loading session: '" session.name "' in cwd: "
                              session.dir)))
            (vim.notify (.. "Session file for '" session.name "' not found")
                        vim.log.levels.ERROR))))

(defn load<-name [name] "Loads a session from a name"
  (let [sessions (-> (json.<-file)
                     (json.decode))]
    (each [_ session# (pairs sessions)]
      (if (= session#.name name)
        (load! session#)
        (vim.notify (.. "Session " name " not found") vim.log.levels.ERROR)))))

(defn create! [session]
      "Creates a new session, stores it and writes the session file"
      (store.file! (store.update session))
      (write! session))

(require :plugins.session.commands)
(require :plugins.session.au)
(au.cursor-hold)
