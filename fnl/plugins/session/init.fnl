(module plugins.session.init
  {autoload {store plugins.session.store.init}})

;;; Primary session management

(defn write [session])

(defn create [] "Creates a new session, stores it"
  (store.store!))
