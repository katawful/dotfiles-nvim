(module plugins.fzf.maps
        {autoload {fzf fzf
                   fzf-lua fzf-lua.init
                   configs plugins.fzf.config
                   launcher plugins.fzf.launchers
                   preview plugins.fzf.git.preview
                   git plugins.fzf.git.init
                   repos plugins.git.repos}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.utils.macros]})

;;; Maps for fzf

;; String -- leader sub key for fzf
(def- fzf-leader :<leader>f)

(nno- (.. fzf-leader :f) (fn []
                          (launcher.files)) "Open FZF file window"
      {:silent true})

(nno- (.. fzf-leader :b) (fn []
                           (launcher.buffers))
      "Open FZF buffer window" {:silent true})

(nno- (.. fzf-leader "'") (fn []
                            (launcher.marks)) "Open FZF marks window"
      {:silent true})

(nno- (.. fzf-leader :g) (fn []
                           (launcher.live-grep))
      "Open FZF live grep window" {:silent true})

(nno- (.. fzf-leader :G) (fn []
                           (launcher.live-grep {:continue_last_search true}))
      "Open FZF live grep window with last search string" {:silent true})

(nno- :z= (fn []
            (launcher.spell-suggest)) "Open FZF spell suggest window"
      {:silent true})

(nno- (.. fzf-leader :h) (fn []
                           (launcher.help-tags))
      "Open FZF help tags window" {:silent true})

(nno- (.. fzf-leader :o)
      (fn []
        (launcher.files {:cwd :/home/kat/Documents/neorg}))
      "Open FZF window of neorg files" {:silent true})

(nno- (.. fzf-leader :c)
      (fn []
        (launcher.files {:cwd :/home/kat/.config/nvim}))
      "Open FZF window of Neovim config directory" {:silent true})

(nno- (.. fzf-leader :d) (fn []
                            (launcher.open-preview repos.dotfiles))
      "Open a FZF window of dotfiles, going to a floating fugitive window"
      {:silent true})

(nno- (.. fzf-leader :n)
      (fn []
        (launcher.open-preview repos.neovim-plugins))
      "Open a FZF window of Neovim plugins, going to a floating fugitive window"
      {:silent true})

(nno- (.. fzf-leader :r) (fn []
                            (launcher.open-preview repos.git-repos))
      "Open a FZF window of git repos, going to a floating fugitive window"
      {:silent true})
