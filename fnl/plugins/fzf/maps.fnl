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

(nno- :<leader>f (fn []
                   (launcher.files)) "Open FZF file window"
      {:silent true})

(nno- :<leader>b (fn []
                   (launcher.buffers)) "Open FZF buffer window"
      {:silent true})

(nno- "<leader>'" (fn []
                    (launcher.marks)) "Open FZF marks window"
      {:silent true})

(nno- :<leader>g (fn []
                   (launcher.live-grep)) "Open FZF live grep window"
      {:silent true})

(nno- :z= (fn []
            (launcher.spell-suggest)) "Open FZF spell suggest window"
      {:silent true})

(nno- :<leader>H (fn []
                   (launcher.help-tags)) "Open FZF help tags window"
      {:silent true})

(nno- :<leader>N (fn []
                   (launcher.files {:cwd :/home/kat/Documents/neorg}))
      "Open FZF window of neorg files" {:silent true})

(nno- :<leader>C (fn []
                   (launcher.files {:cwd :/home/kat/.config/nvim}))
      "Open FZF window of Neovim config directory" {:silent true})

(nno- :<leader>Gd (fn []
                    (launcher.open-preview repos.dotfiles))
      "Open a FZF window of dotfiles, going to a floating fugitive window"
      {:silent true})

(nno- :<leader>Gn (fn []
                    (launcher.open-preview repos.neovim-plugins))
      "Open a FZF window of Neovim plugins, going to a floating fugitive window"
      {:silent true})

(nno- :<leader>Go (fn []
                    (launcher.open-preview repos.git-repos))
      "Open a FZF window of git repos, going to a floating fugitive window"
      {:silent true})
