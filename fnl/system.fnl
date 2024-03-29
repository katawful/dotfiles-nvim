(module system)

;;; System specific information

;; String -- home path acquired from environment
(defonce home-path vim.env.HOME)

;; String -- trimmed system name
(defonce name (string.sub (vim.fn.system "uname -n") 1 -2))

;; String -- path for git repo based on machine
(defonce git-path (.. home-path "/Repos/"))

;; String -- current colorscheme background
(defonce background vim.o.background)

;; String -- raw git root
(defonce git-root "/Repos/")
