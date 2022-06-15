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
