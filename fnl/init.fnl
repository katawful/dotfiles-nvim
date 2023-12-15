(module init {require-macros [katcros-fnl.macros.nvim.api.utils.macros
                              katcros-fnl.macros.nvim.api.autocommands.macros
                              katcros-fnl.macros.nvim.api.options.macros]
              autoload {c aniseed.compile
                        s aniseed.string
                        render katdotnvim.utils.export.render}
              require {: au
                       : config
                       : maps
                       sys system}})

(def plugins [])

(table.insert plugins :folke/lazy.nvim)
(table.insert plugins :Olical/aniseed)
(table.insert plugins {:dir "~/Repos/NEOVIM/katcros-fnl/"})

(table.insert plugins {1 :nvim-treesitter/nvim-treesitter
                       :build ":TSUpdate"
                       :config (fn [] (require :plugins.treesitter.config))})

(table.insert plugins {1 :nvim-treesitter/playground
                       :config (fn [] (require :plugins.treesitter.playground.config))})

(table.insert plugins {:url :https://gitlab.com/HiPhish/nvim-ts-rainbow2
                       :config (fn [] (require :plugins.treesitter.rainbow.config))})

(table.insert plugins {1 :romgrk/nvim-treesitter-context
                       :config (fn [] (require :plugins.treesitter.context.config))})

(table.insert plugins {1 :folke/todo-comments.nvim
                       :config (fn [] (require :plugins.todo-comments.config))})

(table.insert plugins {1 :luckasRanarison/tree-sitter-hypr})

(table.insert plugins {1 :rcarriga/nvim-notify
                       :config (fn [] (set vim.notify (require :notify))
                                 (vim.notify.setup {:stages :slide}))})

(table.insert plugins :katawful/kat.vim)
(table.insert plugins {:dir "~/Repos/NEOVIM/katdotnvim/"
                       :config (fn [] 
                                 (if (= sys.name :builder)
                                     (do
                                       (set-opts {:background :light
                                                  :termguicolors true})
                                       (vim.cmd.colorscheme "kat.nvim"))
                                     (do
                                       (set-opt :termguicolors true)
                                       ((. (require :plugins.colors.time) :set-colors))
                                       ((. (require :plugins.colors.scheme) :set*)))))})

(table.insert plugins {1 :nvim-lualine/lualine.nvim
                       :config (fn [] (require :plugins.lualine.config))})

(table.insert plugins {1 :folke/zen-mode.nvim
                       :config (fn [] (require :plugins.zenmode.config))})

(table.insert plugins :kyazdani42/nvim-web-devicons)

(table.insert plugins {1 :lukas-reineke/indent-blankline.nvim
                       :config (fn [] (require :plugins.indent-blankline.config))})

(table.insert plugins {:dir "~/Repos/NEOVIM/nvim-startify/"})

(table.insert plugins {1 :gelguy/wilder.nvim
                       :build ":UpdateRemotePlugins"
                       :config (fn [] (require :plugins.wilder.config))})

(table.insert plugins {:dir "~/Repos/NEOVIM/syntax-test"})

(table.insert plugins {:dir "~/Repos/NEOVIM/kreative"})

(table.insert plugins :nanozuki/tabby.nvim)

(table.insert plugins {1 :lewis6991/gitsigns.nvim
                       :config (fn [] (require :plugins.gitsigns.config))})

(table.insert plugins {1 :NeogitOrg/neogit
                       :config (fn [] (require :plugins.neogit.config))
                       :dependencies [:nvim-lua/plenary.nvim
                       :nvim-telescope/telescope.nvim]})

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

(table.insert plugins {:dir "~/Repos/OBLIVION/obl.vim"})

(table.insert plugins {:dir "~/Repos/OBLIVION/obluavim"})

(table.insert plugins {1 :katawful/Obli-Vim-Docs
                       :ft :obl})

(table.insert plugins :vim-scripts/bnf.vim)

(table.insert plugins :killphi/vim-ebnf)

(table.insert plugins {1 :SirVer/ultisnips
                       :config (fn [] (require :plugins.ultisnips.config))})

(table.insert plugins {1 :honza/vim-snippets})

(table.insert plugins :tpope/vim-commentary)

(table.insert plugins {1 :IndianBoy42/fuzzy.nvim
                       :dependencies [{1 :nvim-telescope/telescope-fzf-native.nvim
                                       :build "make"}]})
(table.insert plugins {1 :IndianBoy42/fuzzy_slash.nvim
                       :opts {:Fz :Fuz
                              :FzNext :FuzNext
                              :FzPrev :FuzPrev
                              :FzPattern :FuzPattern
                              :FzClear :FuzClear}})

(table.insert plugins {1 :Stormherz/tablify})

(table.insert plugins {1 :sukima/xmledit})

(table.insert plugins {1 :LhKipp/nvim-nu})

(table.insert plugins {1 :neovim/nvim-lspconfig})

(table.insert plugins :williamboman/mason-lspconfig.nvim)

(table.insert plugins {1 :williamboman/mason.nvim
                       :config (fn [] (require :plugins.lsp.config))})

(table.insert plugins {1 :junegunn/fzf
                       :build (fn [] (let [path (.. (do-viml stdpath :data) :/lazy/fzf)
                                           install (.. path "/install")]
                                       (do-viml system [install "--all"])))})

(table.insert plugins {1 :Norlock/nvim-traveller
                       :config (fn [] (require :plugins.traveller.config))})

(table.insert plugins {1 :ibhagwan/fzf-lua
                       :config (fn [] (require :plugins/fzf/config))})

(table.insert plugins :airblade/vim-rooter)

(table.insert plugins :andweeb/presence.nvim)

(table.insert plugins {1 :nvim-neorg/neorg
                       :build ":Neorg sync-parsers"
                       :config (fn [] (require :plugins.neorg.config))
                       :dependencies [:nvim-lua/plenary.nvim]})

((. (require :lazy) :setup) [plugins])
(require :plugins.lazy.config)

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

(require :plugins.tabby.config)