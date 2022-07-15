(module plugins.session.json {autoload {store plugins.session.store.init}})

;;; JSON management for sessions
;;; We need to store sessions to a JSON file for easy management

;; String -- relative config path
(defonce config-path (.. (os.getenv :HOME) :/.config/nvim/))

;; String -- relative stored file path
(defonce stored-file (.. config-path :fnl/plugins/session/stored.json))

(defn encode [session] "Encode lua table as a json" (vim.json.encode session))

(defn decode [json] "Decode json into a lua table" (vim.json.decode json))

(defn ->file! [json] "Store json to file" (os.execute (.. "rm " stored-file))
      (with-open [file (io.open stored-file :w)]
        (file:write json)))

(defn <-file [] "Read stored json"
      (with-open [file (io.open stored-file :r)]
        (if file
            (file:read :*a)
            "{}")))
