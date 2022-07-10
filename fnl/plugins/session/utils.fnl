(module plugins.session.utils
  {autoload {repos plugins.git.repos
             a aniseed.core
             s aniseed.string}})

;;; Utilities for sessions

;; FN -- fix session name
;; @name -- name to fix
;; -- all lowercase and no emoji/nerdfont
;; -- no non-english support tho
(defn fix-name [name]
  "Fixes session name that comes from a different source"
  (let [tbl []]
    (for [i 1 (name:len)]
      (let [char (name:sub i i)]
        (when (string.match char "[%z\1-\127][\128-\191]*$")
          (tset tbl i (: char :lower)))
        (if (= (name:sub i i) " ")
          (tset tbl i "-"))))
    (let [name-tbl (a.vals tbl)]
      (if (= (. name-tbl 1) "-")
        (table.remove name-tbl 1))
      (s.join name-tbl))))

;; FN -- get a name for the session
;; -- searches through my git repos first, if not it gets an input request
(defn get-name []
  "Get a name for the session"
  (let [cur-dir (.. (vim.loop.cwd) "/")
        pre-dir-name {}]
    (each [_ v (pairs repos.dotfiles)]
      (if (cur-dir:find v.dir)
        (do
          (tset pre-dir-name :dir v.dir)
          (tset pre-dir-name :name (fix-name v.name)))))
    (each [_ v (pairs repos.neovim-plugins)]
      (if (cur-dir:find v.dir)
        (do
          (tset pre-dir-name :dir v.dir)
          (tset pre-dir-name :name (fix-name v.name)))))
    (each [_ v (pairs repos.git-repos)]
      (if (cur-dir:find v.dir)
        (do
          (tset pre-dir-name :dir v.dir)
          (tset pre-dir-name :name (fix-name v.name)))))
    (if (not pre-dir-name.dir)
      (do
        (tset pre-dir-name :dir cur-dir)
        (vim.ui.input {:prompt
                       "Enter a session name: "}
                      (fn [input] (tset pre-dir-name :name input)))))))
