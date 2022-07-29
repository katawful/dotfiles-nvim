(module plugins.session.init
        {autoload {store plugins.session.store.init
                   repos plugins.git.repos
                   util plugins.session.utils
                   json plugins.session.json
                   au plugins.session.au
                   sys system
                   a aniseed.core}
         require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;;; Primary session management

;; String -- actual session file name
(defonce session-file (.. "." (string.lower sys.name) :.katsession.vim))

(defn write! [session]
      (let [file (.. session.dir "/" session-file)]
        (vim.schedule (fn []
                        (vim.cmd (.. "mksession! " file))))))

(defn delete! [session] (let [new-session session
                              file (.. session.dir "/" session-file)]
                          (set new-session.mark :delete)
                          (store.file! (store.update new-session))
                          (os.remove file)))

(defn modify! [session-dir] "Modify a session to match to whatever path needed"
      (let [file (.. session-dir "/" session-file)
            git-root (. sys.git-path 1)]
        (with-open [handle (io.open file :r)]
          (print (vim.inspect (handle:read)))
          (let [data (handle:read :*a)]
            (print (string.gsub data (.. "~" (git-root:gsub " " "\\ ")) :test))))))

(defn load! [session] "Load a session file"
      (let [fixed-session-dir (if (= (session.dir:sub -1 -1) "/")
                                  (session.dir:sub 1 -2)
                                  session.dir)
            session-dir (if (fixed-session-dir:find sys.git-path)
                            fixed-session-dir
                            (do
                              (let [tail (vim.fn.fnamemodify fixed-session-dir
                                                             ":t")
                                    git-path (if (= (sys.git-path -1 -1) "/")
                                                 (sys.git-path 1 -2)
                                                 sys.git-path)]
                                (.. git-path "/" tail))))
            file (.. session-dir "/" session-file)]
        (if (= (vim.fn.filereadable file) 1)
            (do
              (vim.cmd (.. "silent! source " file))
              (set-opt cmdheight 2)
              (vim.notify (.. "Loading session: '" session.name "' in cwd: "
                              session-dir)))
            (vim.notify (.. "Session file for '" session.name "' not found")
                        vim.log.levels.ERROR))))

(defn load<-name [name] "Loads a session from a name"
      (let [sessions (-> (json.<-file)
                         (json.decode))]
        (each [_ session# (pairs sessions)]
          (if (= session#.name name)
              (load! session#)
              (vim.notify (.. "Session " name " not found")
                          vim.log.levels.ERROR)))))

(defn create! [session]
      "Creates a new session, stores it and writes the session file"
      (store.file! (store.update session)) (write! session))

(require :plugins.session.commands)
(require :plugins.session.au)
(require :plugins.session.maps)
(au.cursor-hold)
