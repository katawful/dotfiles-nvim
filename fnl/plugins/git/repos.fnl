(module plugins.git.repos {autoload {sys system}})

;;; Module that deals with git repos

;; Key -- Key value table of repo directories
;; structure:
;; name {:dir directory
;;       :desc descrpition
;;       :name name}

;; fnlfmt: skip
(defonce dotfiles {:neovim {:dir (.. sys.home-path "/.config/nvim")
                            :desc "Personal Neovim configs"
                            :name " Neovim Configs"}
                   :i3 {:dir (.. sys.home-path "/.config/i3")
                        :desc "Scripts and config file for i3 window manager"
                        :name "i3 Configs"}
                   :rofi {:dir (.. sys.home-path "/.config/rofi")
                          :desc "Configuration for the rofi menu"
                          :name "rofi Configs"}
                   :polybar {:dir (.. sys.home-path "/.config/polybar")
                             :desc "Configs for the polybar WM bar"
                             :name "Polybar Configs"}})

;; fnlfmt: skip
(defonce neovim-plugins {:katdotnvim {:dir (.. sys.git-path "katdotnvim/")
                                      :desc "My colorscheme, built with Aniseed"
                                      :name :kat.nvim}
                         :kreative {:dir (.. sys.git-path "kreative/")
                                    :desc "Colorscheme backend, analagous to pywal"
                                    :name :Kreative}
                         :obluavim {:dir (.. sys.git-path "obluavim/")
                                    :desc "Filetype plugin for Oblivion"
                                    :name :Obluavim}
                         :katcros-fnl {:dir (.. sys.git-path "katcros-fnl/")
                                       :desc "Fennel macros primarily for Neovim"
                                       :name :katcros-fnl}
                         :obse.vim {:dir (.. sys.git-path "obse.vim/")
                                    :desc "Syntax files for Oblivion"
                                    :name :obse.vim}
                         :nvim-startify {:dir (.. sys.git-path "nvim-startify/")
                                         :desc "Fennel recreation of vim-startify"
                                         :name :nvim-startify}
                         :vim-startify {:dir (.. sys.git-path "vim-startify/")
                                        :desc "Startup page"
                                        :name :Startify}})

;; fnlfmt: skip
(defonce git-repos
         {:oblivion-lang-ref {:dir (.. sys.git-path "oblivion-lang-ref/")
                              :desc "Language reference for Oblivion"
                              :name "Oblivon Language Reference"}
          :tree-sitter-obl {:dir (.. sys.git-path "tree-sitter-obl")
                            :desc "Tree-sitter grammar for Oblivion"
                            :name "Tree-sitter obl"}
          :oblivion-git {:dir (.. sys.git-path "oblivion-git/")
                         :desc "Plugin files"
                         :name "Oblivion Plugins"}
          :katawful.github.io {:dir (.. sys.git-path "katawful.github.io/")
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
