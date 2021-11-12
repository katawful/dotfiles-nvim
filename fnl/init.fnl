(module init
        {require-macros [macros]
         autoload {c aniseed.compile}})
(plugInit
    ;; bootstrap stuff
    (Plug :wbthomason/packer.nvim) ; plugin manager
    (Plug :Olical/aniseed)         ; fennel environment

    ;; fennel dev
    (Plug {1 :Olical/conjure
           :version :4.21.0})   ; REPL tools
    (Plug :bakpakin/fennel.vim) ; enhanced regex syntax highlight

    ;; treesitter
    (Plug {1 :nvim-treesitter/nvim-treesitter
           :run ":TSUpdate"
           :branch "0.5-compat"})              ; tree-sitter main plugin
    (Plug :nvim-treesitter/playground)     ; view AST in real time
    (Plug :p00f/nvim-ts-rainbow)           ; color matching brackets
    (Plug :romgrk/nvim-treesitter-context) ; enhanced colors for embedded languages

    ; lsp
    (Plug :neovim/nvim-lspconfig)

    ;; aesthetics
    (Plug :nanozuki/tabby.nvim)
    ; (Plug :akinsho/nvim-bufferline.lua)         ; buffer/tabline
    (Plug :nvim-lualine/lualine.nvim)                ; statusline
    (Plug :junegunn/goyo.vim)                   ; readable windows
    (Plug :katawful/kat.vim)                    ; color
    (Plug "~/Programs_and_Stuff/Git_Repos/katdotnvim/") ; in progress colorscheme
    (Plug :kyazdani42/nvim-web-devicons)        ; devicons
    (Plug :lukas-reineke/indent-blankline.nvim) ; fill in paragraph lines
    (Plug :mhinz/vim-startify)                  ; vim startscreen
    (Plug :andweeb/presence.nvim)               ; discord presence
    ; (Plug :SmiteshP/nvim-gps)                   ; TS cursor location

    ;; editing plugins
    (Plug :lervag/vimtex)         ; LaTeX tools
    ; (Plug {1 :katawful/Obli-Vim
    ;        :ft :obse})            ; oblivion script syntax and tools
    ; (Plug {1 :katawful/obse.vim   ; Oblivion syntax
    ;        :ft :obse})
    (Plug "~/Programs_and_Stuff/Git_Repos/obse.vim")
    (Plug "~/Programs_and_Stuff/Git_Repos/obluavim")
    (Plug {1 :katawful/Obli-Vim-Docs
           :ft :obse})            ; OBSE docs
    (Plug :SirVer/ultisnips)      ; snippet engine
    (Plug :tpope/vim-commentary)  ; comment management
    (Plug :ggandor/lightspeed.nvim) ; lightspeed
    ; (Plug :hrsh7th/nvim-cmp) ; nvim-cmp
    ; (Plug :hrsh7th/cmp-nvim-lsp)
    ; (Plug {1 :nvim-telescope/telescope.nvim
    ;        :requires :nvim-lua/plenary.nvim
    ;        })

    ;; usability plugins
    (Plug {1 :junegunn/fzf
           :run (fn []
                  (. vim.fn "fzf#install"))}) ; main FZF binary
    (Plug :junegunn/fzf.vim)                  ; bindings for FZF in vim
    (Plug :tpope/vim-fugitive)                ; git management
    (Plug :airblade/vim-rooter)               ; puts vim to the root directory if possible

    ;; diary and wiki
    (Plug :mattn/calendar-vim)                ; calendar
    (Plug :vimwiki/vimwiki)                   ; personal wiki
    (Plug {1 :nvim-neorg/neorg
           :branch :unstable
           :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
    :config {:display {:open_fn (. (require :packer.util) :float)}})

; compile non-fnl files
; after/ftplugin
(c.glob "*.fnl" "/home/kat/after/ftplugin" "/home/kat/after/ftplugin")
; plugin
(c.glob "*.fnl" "/home/kat/plugin" "/home/kat/plugin")
; autoload
(c.glob "*.fnl" "/home/kat/autoload" "/home/kat/autoload")
; ftplugin
(c.glob "*.fnl" "/home/kat/ftplugin" "/home/kat/ftplugin")

; (let- :g :kat_nvim_style :dark)
; (let- :g :kat_nvim_contrast :soft)
; (let- :g :kat_nvim_stupidFeatures true)
(let- :g :kat_nvim_integrations {1 :treesitter
                                 2 :lsp
                                 3 :ts_rainbow
                                 4 :indent_blankline
                                 5 :startify
                                 })
; (let- :g :kat_nvim_filetype {1 :vim
;                              2 :vimwiki
;                              3 :markdown
;                              })
; (vim.lsp.set_log_level :debug)
(require :plugins/core)
(require :config)
(require :au)
(require :maps)
(require :tshighlight)

(require :plug/core)
