(module init {require-macros [katcros-fnl.macros.nvim.packer.macros
                              katcros-fnl.macros.nvim.api.utils.macros
                              katcros-fnl.macros.nvim.api.autocommands.macros
                              katcros-fnl.macros.nvim.api.options.macros]
              autoload {c aniseed.compile
                        s aniseed.string
                        render katdotnvim.utils.export.render}})

; call global settings
(require :au)
(require :config)
(require :maps)

; check if our compiled packer file exists and source it
(defn checkForCompile [] (let [file (io.open :/home/kat/.config/nvim/lua/packer_compiled.lua
                                             :r)]
                           (if (not= file nil)
                               (do
                                 (io.close file)
                                 (require :packer_compiled))
                               (do
                                 false))))

(checkForCompile)

((. (require :packer) :startup) {1 (fn [use]
                                     ;;; bootstrap stuff
                                     ;; macros
                                     (Plug "~/Git Repos/katcros-fnl/") ; (Plug "katawful/katcros-fnl")
                                     ;; plugin manager
                                     (Plug :wbthomason/packer.nvim)
                                     ;; fennel environment
                                     (Plug :Olical/aniseed)
                                     ;; fast loader
                                     (Plug :lewis6991/impatient.nvim)
                                     (Plug {1 :rcarriga/nvim-notify
                                            :config (fn []
                                                      (set vim.notify
                                                           (require :notify))
                                                      (vim.notify.setup {:stages :slide}))})
                                     ;;; fennel dev
                                     (Plug {1 :Olical/conjure
                                            :branch :develop
                                            :config (fn []
                                                      (require :plugins.conjure.config))})
                                     ;;; treesitter
                                     (Plug {1 :nvim-treesitter/nvim-treesitter
                                            :run ":TSUpdate"
                                            :config (fn []
                                                      (require :plugins.treesitter.config))})
                                     ;; tree-sitter main plugin
                                     (Plug {1 :nvim-treesitter/playground
                                            :config (fn []
                                                      (require :plugins.treesitter.playground.config))})
                                     ;; view AST in real time
                                     (Plug {1 :p00f/nvim-ts-rainbow
                                            :config (fn []
                                                      (require :plugins.treesitter.rainbow.config))})
                                     ;; color matching brackets
                                     (Plug {1 :romgrk/nvim-treesitter-context
                                            :config (fn []
                                                      (require :plugins.treesitter.context.config))})
                                     ;; enhanced colors for embedded languages
                                     (Plug {1 :nvim-treesitter/nvim-tree-docs
                                            :config (fn []
                                                      (require :plugins.treesitter.docs.config))})
                                     (Plug {1 :SmiteshP/nvim-gps
                                            :config (fn []
                                                      (require :plugins.nvim-gps.config))})
                                     ;; TS cursor location
                                     ;;; lsp
                                     (Plug {1 :neovim/nvim-lspconfig})
                                     (Plug :williamboman/mason-lspconfig.nvim)
                                     (Plug {1 :williamboman/mason.nvim
                                            :config (fn []
                                                      (require :plugins.lsp.config))})
                                     (Plug {1 :lewis6991/gitsigns.nvim
                                            :config (fn []
                                                      (require :plugins.gitsigns.config))})
                                     ;;; aesthetics
                                     ;; vimscript colorscheme
                                     (Plug :katawful/kat.vim)
                                     ;; lua colorscheme
                                     (Plug {1 "~/Git Repos/katdotnvim/"
                                            :config (fn []
                                                      ((. (require :plugins.colors.time)
                                                          :set-colors))
                                                      ((. (require :plugins.colors.scheme)
                                                          :set*)))})
                                     ;; statusline
                                     (Plug {1 :nvim-lualine/lualine.nvim
                                            :config (fn []
                                                      (require :plugins.lualine.config))})
                                     ;; isolated window
                                     (Plug {1 :junegunn/goyo.vim
                                            :config (fn []
                                                      (require :plugins.goyo.config))})
                                     ;; devicons
                                     (Plug :kyazdani42/nvim-web-devicons)
                                     ;; show indents
                                     (Plug {1 :lukas-reineke/indent-blankline.nvim
                                            :config (fn []
                                                      (require :plugins.indent-blankline.config))})
                                     ;; startup
                                     (Plug {1 "~/Git Repos/vim-startify/"
                                            :config (fn []
                                                      (require :plugins.startify.config))})
                                     ;; discord rich presence
                                     (Plug :andweeb/presence.nvim)
                                     ;;; editing plugins
                                     ;; rust based parinfer
                                     (Plug {1 :eraserhd/parinfer-rust
                                            :run "cargo build --release"})
                                     ;; latex tools
                                     (Plug {1 :lervag/vimtex
                                            :config (fn []
                                                      (require :plugins.latex.config))})
                                     ;; oblivion syntax
                                     (Plug "~/Git Repos/obse.vim")
                                     ;; in progress oblivion dev tools
                                     (Plug "~/Git Repos/obluavim")
                                     ;; OBSE docs
                                     (Plug {1 :katawful/Obli-Vim-Docs
                                            :ft :obse})
                                     ;; snippet engine
                                     (Plug {1 :SirVer/ultisnips
                                            :config (fn []
                                                      (require :plugins.ultisnips.config))})
                                     ;; comment management
                                     (Plug :tpope/vim-commentary)
                                     ;; command-line completion
                                     (Plug {1 :gelguy/wilder.nvim
                                            :config (fn []
                                                      (require :plugins.wilder.config))})
                                     ;; syntax tester
                                     (Plug "~/Git Repos/syntax-test")
                                     ;; colorscheme generator
                                     (Plug "~/Git Repos/kreative")
                                     (Plug :vim-scripts/bnf.vim)
                                     (Plug :killphi/vim-ebnf)
                                     (Plug {1 :junegunn/fzf
                                            :run "./install --all"})
                                     (Plug {1 "~/Git Repos/dirbuf.nvim"
                                            :config (fn []
                                                      (require :plugins.dirbuf.config))})
                                     (Plug {1 :ibhagwan/fzf-lua
                                            :requires :vijaymarupudi/nvim-fzf
                                            :config (fn []
                                                      (require :plugins/fzf/config))})
                                     (Plug {1 :tpope/vim-fugitive
                                            :config (fn []
                                                      (require :plugins.fugitive.config))})
                                     (Plug :airblade/vim-rooter) ; rooter
                                     ;; beta personal wiki
                                     (Plug {1 :nvim-neorg/neorg
                                            :tag :0.0.12
                                            :config (fn []
                                                      (require :plugins.neorg.config))
                                            :requires :nvim-lua/plenary.nvim})
                                     (Plug :psliwka/termcolors.nvim)
                                     (Plug {1 :nanozuki/tabby.nvim})
                                     (Plug {1 :antoinemadec/FixCursorHold.nvim
                                            :config (fn []
                                                      (require :plugins.cursorhold.config))})
                                     (Plug {1 :kyazdani42/nvim-tree.lua
                                            :config (fn []
                                                      (require :plugins.nvim-tree.config))}))
                                 :config {:display {:open_fn (. (require :packer.util)
                                                                :float)}
                                          :compile_path (.. (vim.fn.stdpath :config)
                                                            :/lua/packer_compiled.lua)}})

;; compile non-fnl files
; after/ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/after/ftplugin
        :/home/kat/.config/nvim/after/ftplugin)

; plugin
(c.glob :*.fnl :/home/kat/.config/nvim/plugin :/home/kat/.config/nvim/plugin)
; autoload
(c.glob :*.fnl :/home/kat/.config/nvim/autoload
        :/home/kat/.config/nvim/autoload)

; ftplugin
(c.glob :*.fnl :/home/kat/.config/nvim/ftplugin
        :/home/kat/.config/nvim/ftplugin)

((. (require :plugins.colors.scheme) :set*))
(require :plugins.tabby.config)

; see if we need to compile packer
(if (= (checkForCompile) false)
    ((. (require :packer) :compile)))

(require :plugins.session.init)

; tabby needs to load last for the colors to appear proper
; ((. (require :tabby) :setup))
