(module init {require-macros [katcros-fnl.macros.nvim.packer.macros
                              katcros-fnl.macros.nvim.api.utils.macros
                              katcros-fnl.macros.nvim.api.autocommands.macros
                              katcros-fnl.macros.nvim.api.options.macros]
              autoload {c aniseed.compile
                        s aniseed.string
                        render katdotnvim.utils.export.render}
              require {: au
                       : config
                       : maps
                       sys system}})
(defn checkForCompile [] (let [file (io.open :/home/kat/.config/nvim/lua/packer_compiled.lua
                                             :r)]
                           (if (not= file nil)
                               (do
                                 (io.close file)
                                 (require :packer_compiled))
                               (do
                                 false))))
(checkForCompile)
(def plugins [])
(table.insert plugins "~/Git Repos/katcros-fnl/")
(table.insert plugins :wbthomason/packer.nvim)
(table.insert plugins :Olical/aniseed)
(table.insert plugins :lewis6991/impatient.nvim)
(table.insert plugins {1 :nvim-treesitter/nvim-treesitter
                       :run ":TSUpdate"
                       :config (fn [] (require :plugins.treesitter.config))})
(table.insert plugins {1 :nvim-treesitter/playground
                       :config (fn [] (require :plugins.treesitter.playground.config))})
(table.insert plugins {1 :p00f/nvim-ts-rainbow
                       :config (fn [] (require :plugins.treesitter.rainbow.config))})
(table.insert plugins {1 :romgrk/nvim-treesitter-context
                       :config (fn [] (require :plugins.treesitter.context.config))})
(table.insert plugins {1 :rcarriga/nvim-notify
                       :config (fn [] (set vim.notify (require :notify))
                                 (vim.notify.setup {:stages :slide}))})
(table.insert plugins :katawful/kat.vim)
(table.insert plugins {1 "~/Git Repos/katdotnvim/"
                       :config (fn [] ((. (require :plugins.colors.time) :set-colors))
                                 ((. (require :plugins.colors.scheme) :set*)))})
(table.insert plugins {1 :nvim-lualine/lualine.nvim
                       :config (fn [] (require :plugins.lualine.config))})
(table.insert plugins {1 :junegunn/goyo.vim
                       :config (fn [] (require :plugins.goyo.config))})
(table.insert plugins :kyazdani42/nvim-web-devicons)
(table.insert plugins {1 :lukas-reineke/indent-blankline.nvim
                       :config (fn [] (require :plugins.indent-blankline.config))})
(table.insert plugins {1 "~/Git Repos/vim-startify/"
                       :config (fn [] (require :plugins.startify.config))})
(table.insert plugins {1 :gelguy/wilder.nvim
                       :config (fn [] (require :plugins.wilder.config))})
(table.insert plugins "~/Git Repos/syntax-test")
(table.insert plugins "~/Git Repos/kreative")
(table.insert plugins :nanozuki/tabby.nvim)
(table.insert plugins {1 :lewis6991/gitsigns.nvim
                       :config (fn [] (require :plugins.gitsigns.config))})
(table.insert plugins {1 :tpope/vim-fugitive
                       :config (fn [] (require :plugins.fugitive.config))})
(table.insert plugins {1 :Olical/conjure
                       :branch :develop
                       :config (fn [] (require :plugins.conjure.config))})
(table.insert plugins {1 :eraserhd/parinfer-rust
                       :run "cargo build --release"})
(table.insert plugins {1 :lervag/vimtex
                       :config (fn [] (require :plugins.latex.config))})
(table.insert plugins "~/Git Repos/obse.vim")
(table.insert plugins "~/Git Repos/obluavim")
(table.insert plugins {1 :katawful/Obli-Vim-Docs
                       :ft :obse})
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
                       :run "./install --all"})
(table.insert plugins {1 "~/Git Repos/dirbuf.nvim"
                       :config (fn [] (require :plugins.dirbuf.config))})
(table.insert plugins {1 :ibhagwan/fzf-lua
                       :requires :vijaymarupudi/nvim-fzf
                       :config (fn [] (require :plugins/fzf/config))})
(table.insert plugins :airblade/vim-rooter)
(table.insert plugins :andweeb/presence.nvim)
(table.insert plugins {1 "~/Git Repos/neorg/"
                       :config (fn [] (require :plugins.neorg.config))
                       :requires :nvim-lua/plenary.nvim})
((. (require :packer) :startup) {1 (fn [use] (each [_ v (ipairs plugins)] (use v)))
                                 :config {:display {:open_fn (. (require :packer.util)
                                                                :float)}
                                          :compile_path (.. (vim.fn.stdpath :config)
                                                            :/lua/packer_compiled.lua)}})
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
; see if we need to compile packer
(if (= (checkForCompile) false)
    ((. (require :packer) :compile)))
(require :plugins.session.init)
(require :plugins.tabby.config)