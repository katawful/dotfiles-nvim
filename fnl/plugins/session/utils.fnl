(module plugins.session.utils
        {autoload {repos plugins.git.repos a aniseed.core s aniseed.string}})

;;; Utilities for sessions

;; FN -- fix session name
;; @name -- name to fix
(defn fix-name [name] "Fixes session name that comes from a different source
Removes all multibyte strings, at the cost of English only characters
Makes sure to remove leading hypen
Converts spaces to hyphens"
      (let [tbl []]
        (for [i 1 (name:len)]
          (let [char (name:sub i i)]
            (when (string.match char "[%z\001-\127][\128-\191]*$")
              (tset tbl i (: char :lower)))
            (if (= (name:sub i i) " ")
                (tset tbl i "-"))))
        (let [name-tbl (a.vals tbl)]
          (if (= (. name-tbl 1) "-")
              (table.remove name-tbl 1))
          (s.join name-tbl))))

;; FN -- generates a table of needed information for sessions
(defn generate$ [] "Generate the needed information for the user for a session
Parses tables from plugins.git.repos for names I use, making sure to fix them
Asks for input if a matched directory was not found
Asks for input for last thing done for this session"
      (let [cur-dir (.. (vim.loop.cwd) "/")
            ; added a / to the end so we could always find cur-dir
            session {}]
        (each [_ v (pairs repos.dotfiles)]
          (if (= cur-dir v.dir)
              (do
                (tset session :dir v.dir)
                (tset session :name (fix-name v.name)))))
        (each [_ v (pairs repos.neovim-plugins)]
          (if (= cur-dir v.dir)
              (do
                (tset session :dir v.dir)
                (tset session :name (fix-name v.name)))))
        (each [_ v (pairs repos.git-repos)]
          (if (= cur-dir v.dir)
              (do
                (tset session :dir v.dir)
                (tset session :name (fix-name v.name)))))
        (if (not session.dir)
            (do
              (tset session :dir cur-dir)
              (vim.ui.input {:prompt "Enter a session name: "}
                            (fn [input]
                              (tset session :name (fix-name input))))))
        (vim.ui.input {:prompt "Describe the last thing you were doing: "}
                      (fn [input]
                        (tset session :last input)))
        session))

(defn empty? [] "Is the current Neovim session empty?
We don't want to deal with sessions when we just booted up Neovim"
 (let [buffers (vim.api.nvim_exec "buffers" true)]
   (if (= (length buffers) 0)
     true
     false)))
