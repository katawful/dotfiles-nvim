(module init {require-macros [katcros-fnl.macros.nvim.packer.macros
                              katcros-fnl.macros.nvim.api.utils.macros
                              katcros-fnl.macros.nvim.api.autocommands.macros
                              katcros-fnl.macros.nvim.api.options.macros]
              require {c aniseed.compile
                       s aniseed.string
                       render katdotnvim.utils.export.render
                       : au
                       : config
                       : maps
                       sys system}})
(def plugins [])
(table.insert plugins :folke/lazy.nvim)
(table.insert plugins :Olical/aniseed)
(table.insert plugins {:dir "~/Git Repos/katcros-fnl/"})
(table.insert plugins {1 :nvim-treesitter/nvim-treesitter
                       :bulid ":TSUpdate"
                       :config (fn [] (require :plugins.treesitter.config))})
(table.insert plugins {1 :nvim-treesitter/playground
                       :config (fn [] (require :plugins.treesitter.playground.config))})
(table.insert plugins {1 :p00f/nvim-ts-rainbow
                       :config (fn [] (require :plugins.treesitter.rainbow.config))})
(table.insert plugins {1 :romgrk/nvim-treesitter-context
                       :config (fn [] (require :plugins.treesitter.context.config))})
(table.insert plugins {1 :folke/todo-comments.nvim
                       :config (fn [] (require :plugins.todo-comments.config))})
(table.insert plugins {1 :rcarriga/nvim-notify
                       :config (fn [] (set vim.notify (require :notify))
                                 (vim.notify.setup {:stages :slide}))})
(table.insert plugins :katawful/kat.vim)
(table.insert plugins {:dir "~/Git Repos/katdotnvim/"
                       :config (fn [] ((. (require :plugins.colors.time) :set-colors))
                                 ((. (require :plugins.colors.scheme) :set*)))})
(table.insert plugins {1 :nvim-lualine/lualine.nvim
                       :config (fn [] (require :plugins.lualine.config))})
(table.insert plugins {1 :junegunn/goyo.vim
                       :config (fn [] (require :plugins.goyo.config))})
(table.insert plugins :kyazdani42/nvim-web-devicons)
(table.insert plugins {1 :lukas-reineke/indent-blankline.nvim
                       :config (fn [] (require :plugins.indent-blankline.config))})
(table.insert plugins {:dir "~/Git Repos/vim-startify/"
                       :config (fn [] (require :plugins.startify.config))})
(table.insert plugins {1 :gelguy/wilder.nvim
                       :config (fn [] (require :plugins.wilder.config))})
(table.insert plugins {:dir "~/Git Repos/syntax-test"})
(table.insert plugins {:dir "~/Git Repos/kreative"})
(table.insert plugins :nanozuki/tabby.nvim)
(table.insert plugins {1 :lewis6991/gitsigns.nvim
                       :config (fn [] (require :plugins.gitsigns.config))})
(table.insert plugins {1 :tpope/vim-fugitive
                       :config (fn [] (require :plugins.fugitive.config))})
(table.insert plugins {1 :Olical/conjure
                       :branch :develop
                       :config (fn [] (require :plugins.conjure.config))})
(table.insert plugins {1 :eraserhd/parinfer-rust
                       :build (let [path (.. (do-viml stdpath :data) :/lazy/parinfer-rust)]
                                (string.format "(cd %s; cargo build --release)"
                                               path))})
(table.insert plugins {1 :lervag/vimtex
                       :config (fn [] (require :plugins.latex.config))})
(table.insert plugins {:dir "~/Git Repos/obl.vim"})
(table.insert plugins {:dir "~/Git Repos/obluavim"})
(table.insert plugins {1 :katawful/Obli-Vim-Docs
                       :ft :obl})
(table.insert plugins :vim-scripts/bnf.vim)
(table.insert plugins :killphi/vim-ebnf)
(table.insert plugins {1 :SirVer/ultisnips
                       :config (fn [] (require :plugins.ultisnips.config))})
(table.insert plugins :tpope/vim-commentary)
(table.insert plugins {1 :neovim/nvim-lspconfig})
(table.insert plugins :williamboman/mason-lspconfig.nvim)
(table.insert plugins {1 :williamboman/mason.nvim
                       :config (fn [] (require :plugins.lsp.config))})
(table.insert plugins {1 :junegunn/fzf
                       :build (fn [] (let [path (.. (do-viml stdpath :data) :/lazy/fzf)
                                           install (.. path "/install")]
                                       (do-viml system [install "--all"])))})
(table.insert plugins {:dir "~/Git Repos/dirbuf.nvim"
                       :config (fn [] (require :plugins.dirbuf.config))})
(table.insert plugins {1 :ibhagwan/fzf-lua
                       :config (fn [] (require :plugins/fzf/config))})
(table.insert plugins :airblade/vim-rooter)
(table.insert plugins :andweeb/presence.nvim)
(table.insert plugins {1 :nvim-neorg/neorg
                       :config (fn [] (require :plugins.neorg.config))
                       :dependencies [:nvim-lua/plenary.nvim]})
((. (require :lazy) :setup) [plugins])
;;; after/ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/after/ftplugin
        :/home/kat/.config/nvim/after/ftplugin)
;;; plugin
(c.glob :*.fnl :/home/kat/.config/nvim/plugin :/home/kat/.config/nvim/plugin)
;;; autoload
(c.glob :*.fnl :/home/kat/.config/nvim/autoload
        :/home/kat/.config/nvim/autoload)
;;; ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/ftplugin
        :/home/kat/.config/nvim/ftplugin)
(require :plugins.session.init)
(require :plugins.tabby.config)