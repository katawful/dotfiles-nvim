(module plugins.git.repos)

;;; Module that deals with git repos

;; Table of dotfile repos
;; structure:
;; name {:dir directory
;;       :desc descrpition
;;       :name name}
(defonce dotfiles
  {
   :neovim {:dir "~/.config/nvim"
            :desc "Personal Neovim configs"
            :name " Neovim Configs"}
   :i3 {:dir "~/.config/i3"
        :desc "Scripts and config file for i3 window manager"
        :name "i3 Configs"}
   :rofi {:dir "~/.config/rofi"
          :desc "Configuration for the rofi menu"
          :name "rofi Configs"}})

(defonce neovim-plugins
  {
   :katdotnvim {:dir "~/Programs_and_Stuff/Git_Repos/katdotnvim/"
                :desc "My colorscheme, built with Aniseed"
                :name "kat.nvim"}
   :kreative {:dir "~/Programs_and_Stuff/Git_Repos/kreative"
              :desc "Colorscheme backend, analagous to pywal"
              :name "Kreative"}
   :obluavim {:dir "~/Programs_and_Stuff/Git_Repos/obluavim"
              :desc "Filetype plugin for Oblivion"
              :name "Obluavim"}
   :katcros-fnl {:dir "~/Programs_and_Stuff/Git_Repos/katcros-fnl/"
                 :desc "Fennel macros primarily for Neovim"
                 :name "katcros-fnl"}
   :obse.vim {:dir "~/Programs_and_Stuff/Git_Repos/obse.vim"
              :desc "Syntax files for Oblivion"
              :name "obse.vim"}})

;; FN -- get status of a repo
;; @repo -- indexed repo from a specified table
(defn status [repo] "Get the status of a repo"
  (let [status (vim.fn.system (string.format "git -C %s status" repo))]
    status))

;; FN -- get a directories for repos
;; @repo-type -- the main repo to use
(defn directories [repo-type] "Get a list of directories for output to FZF"
  (let [dir-table []]
    (each [k v (pairs repo-type)]
      (let [current-repo (. repo-type k)]
        (table.insert dir-table current-repo.dir)))
    dir-table))
