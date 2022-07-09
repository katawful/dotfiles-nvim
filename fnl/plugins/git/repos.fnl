(module plugins.git.repos)

;;; Module that deals with git repos

;; String -- home path acquired from environment
(defonce- home-path vim.env.HOME)

;; String -- path for git repo based on machine
(defonce- git-path
  (let [uname (vim.fn.system "uname -n")]
    (if (= uname "Kat-Arch\n")
      (.. home-path "/Programs_and_Stuff/Git_Repos/")
      (.. home-path "/Git Repos/"))))


;; Key -- Key value table of repo directories
;; structure:
;; name {:dir directory
;;       :desc descrpition
;;       :name name}
;; fnlfmt: skip
(defonce dotfiles {:neovim {:dir (.. home-path "/.config/nvim")
                            :desc "Personal Neovim configs"
                            :name " Neovim Configs"}
                   :i3 {:dir (.. home-path "/.config/i3")
                        :desc "Scripts and config file for i3 window manager"
                        :name "i3 Configs"}
                   :rofi {:dir (.. home-path "/.config/rofi")
                          :desc "Configuration for the rofi menu"
                          :name "rofi Configs"}
                   :polybar {:dir (.. home-path "/.config/polybar")
                             :desc "Configs for the polybar WM bar"
                             :name "Polybar Configs"}})

;; fnlfmt: skip
(defonce neovim-plugins {:katdotnvim {:dir (.. git-path "katdotnvim/")
                                      :desc "My colorscheme, built with Aniseed"
                                      :name :kat.nvim}
                         :kreative {:dir (.. git-path "kreative/")
                                    :desc "Colorscheme backend, analagous to pywal"
                                    :name :Kreative}
                         :obluavim {:dir (.. git-path "obluavim/")
                                    :desc "Filetype plugin for Oblivion"
                                    :name :Obluavim}
                         :katcros-fnl {:dir (.. git-path "katcros-fnl/")
                                       :desc "Fennel macros primarily for Neovim"
                                       :name :katcros-fnl}
                         :obse.vim {:dir (.. git-path "obse.vim/")
                                    :desc "Syntax files for Oblivion"
                                    :name :obse.vim}})

;; fnlfmt: skip
(defonce git-repos
         {:oblivion-lang-ref {:dir (.. git-path "oblivion-lang-ref/")
                              :desc "Language reference for Oblivion"
                              :name "Oblivon Language Reference"}
          :tree-sitter-obse {:dir (.. git-path "tree-sitter-obse/")
                             :desc "Tree-sitter grammar for Oblivion"
                             :name "Tree-sitter OBSE"}
          :oblivion-git {:dir (.. git-path "oblivion-git/")
                         :desc "Plugin files"
                         :name "Oblivion Plugins"}
          :katawful.github.io {:dir (.. git-path "katawful.github.io/")
                               :desc "Website hosted by GitHub"
                               :name "katawful.github.io"}})

;; FN -- get status of a repo
;; @repo -- indexed repo from a specified table
(defn status [repo] "Get the status of a repo"
      (let [status (vim.fn.system (string.format "git -C \"%s\" status" repo))]
        status))

;; FN -- get a directories for repos
;; @repo-type -- the main repo to use
(defn directories [repo-type] "Get a list of directories for output to FZF"
      (let [dir-table []]
        (each [k v (pairs repo-type)]
          (let [current-repo (. repo-type k)]
            (table.insert dir-table current-repo.dir)))
        dir-table))
