(module plugins.fzf.commands
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

;;; User commands for fzf

(command- :KatFZFSearchDir (fn []
                             (launcher.search-dirs))
          "Search for directories")

(command- :KatFZFOpenFile (fn []
                            (launcher.files))
          "Open files")

(command- :KatFZFOpenBuffers (fn []
                               (launcher.buffers))
          "Open buffers")

(command- :KatFZFOpenMarks (fn []
                             (launcher.marks))
          "Open marks")

(command- :KatFZFOpenGrep (fn []
                            (launcher.live-grep))
          "Open live grep")

(command- :KatFZFOpenHelpTags
          (fn []
            (launcher.help-tags)) "Open help files")

(command- :KatFZFGetDotfiles
          (fn []
            (launcher.open-preview repos.dotfiles)) "Get dotfiles")

(command- :KatFZFGetNeovimPlugins
          (fn []
            (launcher.open-preview repos.neovim-plugins))
          "Get neovim plugin directories")

(command- :KatFZFGetGitRepos
          (fn []
            (launcher.open-preview repos.git-repos))
          "Get other git repositories")

(command- :KatFZFSearchDirectory
          (fn []
            (launcher.search-dirs))
          "Search through current directory")

(command- :KatFZFGetSessions
          (fn []
            (launcher.search-sessions))
          "Search through sessions")

(command- :KatFZFSearchNeorgWorkspaces
          (fn []
            (vim.cmd "silent! NeorgStart silent=true")
            (launcher.search-neorg-workspaces))
          "Search through Neorg workspaces")
