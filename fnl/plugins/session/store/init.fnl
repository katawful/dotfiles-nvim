(module plugins.session.store.init
        {autoload {a aniseed.core
                   c aniseed.compile
                   util plugins.session.utils
                   json plugins.session.json
                   format plugins.fnlfmt.format}})

;;; Handles storing session information to a file
;;; Stored file fnl/plugins.session.stored.fnl:
;;; (module plugins.session.stored)
;;; (def sessions
;;;   {session-1.name {}
;;;    session-2.name {}})

;; String -- module header for the session file
(defonce header "(module plugins.session.stored)\n")

;; String -- table definition with string format
(defonce tbl "(defn sessions []\n%s\n )")

;; String -- relative config path
(defonce config-path (.. (vim.loop.os_getenv "HOME") :/.config/nvim/))

;; String -- relative stored file path
(defonce stored-file (.. config-path :fnl/plugins/session/stored.fnl))

;; String -- relative stored file path
(defonce stored-file-lua (.. config-path :lua/plugins/session/stored.lua))

(defn last [] "Get the last stored sessions table
Because I am using a Fennel file to store all of this information,
as opposed to a data file like JSON, I have to both compile the Fennel file
with Aniseed and source the compiled Lua file with an Ex command"
      (vim.schedule_wrap (fn [] (c.file stored-file stored-file-lua)))
      (vim.schedule_wrap (fn [] (vim.cmd (.. "source " stored-file-lua))))
      ((. (require :plugins.session.stored) :sessions)))

(defn update [session] "Update sessions table with session provided
Checks if session already exists and updates it"
      (let [stored (-> (json.<-file)
                       (json.decode))
            new {}]
        (when stored
          (each [k v (pairs stored)]
            (if (= session.name v.name)
                (tset new k session) ; update with new name value if exist
                (and (= session.dir v.dir) (not= session.name v.name))
                (tset new session.name session) ; update with different name value, but same dir
                (tset new k v)))) ; add non-matching values unadulterated
        ;; check through output sessions table to see if we didn't add new session
        (if (not= (a.get new.name session.name) session.name)
            (tset new session.name session))
        ;; make sure to remove a deleted session
        (if (= session.mark :delete)
            (tset new session.name nil))
        new))

(defn file! [sessions] "Stores session table as a fnl file to a specified location
Is a literal file, reconstructed upon each store
Checks if file exists first before starting"
      (json.->file! (json.encode sessions)))

; (file! (update (util.generate$)))
