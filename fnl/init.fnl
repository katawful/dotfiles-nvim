(module init
        {require-macros [macros]
         autoload {c aniseed.compile
                   }})

; call global settings
(require :au)
(require :config)
(require :maps)

; check if our compiled packer file exists and source it
(defn checkForCompile []
  (let [file (io.open "/home/kat/lua/packer_compiled.lua" "r")]
    (if (not= file nil)
      (do
        (io.close file)
        (require :packer_compiled))
      (do
        false
        ))))
(checkForCompile)

((. (require :packer) :startup) {1 (fn [use]

  ;; bootstrap stuff
  (Plug :wbthomason/packer.nvim)   ; plugin manager
  (Plug :Olical/aniseed)           ; fennel environment
  (Plug :lewis6991/impatient.nvim) ; faster loading

  ;; fennel dev
  (Plug {1 :Olical/conjure
         :version :4.27.0
         })            ; REPL tools
  (Plug {1 :bakpakin/fennel.vim
         :ft :fennel}) ; enhanced regex syntax highlight

  ;; treesitter
  (Plug {1 :nvim-treesitter/nvim-treesitter
         :run ":TSUpdate"
         :config (fn []
                   (require :plug/treesitter))}) ; tree-sitter main plugin
  (Plug {1 :nvim-treesitter/playground
         :config (fn []
                   (require :plug/playground))}) ; view AST in real time
  (Plug {1 :p00f/nvim-ts-rainbow
         :config (fn []
                   (require :plug/rainbow_con))}) ; color matching brackets
  (Plug {1 :romgrk/nvim-treesitter-context
         :config (fn []
                   (require :plug/treesitter-context_con))}) ; enhanced colors for embedded languages

  ;; lsp
  (Plug {1 :neovim/nvim-lspconfig
         :requires :williamboman/nvim-lsp-installer
         :config (fn []
                   (require :plug/lspconfig_con))
         })

  ;; aesthetics
  (Plug :katawful/kat.vim) ; vimscript colorscheme
  (Plug {1 "~/Programs_and_Stuff/Git_Repos/katdotnvim/"
         :config (fn []
                   (let [timeLocal (tonumber (vim.fn.strftime "%H"))]
                     (let- :g :kat_nvim_integrations
                       {1 :treesitter
                        2 :lsp
                        3 :ts_rainbow
                        4 :indent_blankline
                        5 :startify
                        })
                     (if (and (> timeLocal 20)
                              (<= timeLocal 8))
                       (col- "kat.nvim")
                       (and (> timeLocal 8)
                            (<= timeLocal 12))
                       (col- "kat.lightenwim")
                       (and (> timeLocal 12)
                            (<= timeLocal 15))
                       (col- "kat.lightenvim")
                       (and (> timeLocal 15)
                            (<= timeLocal 20))
                       (col- "kat.nwim")
                       (col- "kat.nvim"))))}) ; fennel colorscheme

  (Plug :nanozuki/tabby.nvim)
  ; (Plug :akinsho/nvim-bufferline.lua)         ; buffer/tabline
  (Plug {1 :nvim-lualine/lualine.nvim
         :config (fn []
                   (require :plug/lualine_con))})  ; statusline
  (Plug {1 :junegunn/goyo.vim
         :config (fn []
                   (require :plug/goyo))})    ; readable windows
  (Plug :kyazdani42/nvim-web-devicons)        ; devicons
  (Plug {1 :lukas-reineke/indent-blankline.nvim
         :config (fn []
                   (require :plug/indentline))}) ; fill in paragraph lines
  (Plug {1 :mhinz/vim-startify
         :config (fn []
                   (require :plug/startify))}); vim startscreen
  (Plug :andweeb/presence.nvim)               ; discord presence
  ; (Plug {1 :SmiteshP/nvim-gps
  ;        :config (require :plug/nvim-gps_con)}); TS cursor location

  ;; editing plugins
  (Plug {1 :lervag/vimtex
         :config (fn []
                   (require :plug/vimtex))}); LaTeX tools
  ; (Plug {1 :katawful/Obli-Vim
  ;        :ft :obse})            ; oblivion script syntax and tools
  ; (Plug {1 :katawful/obse.vim   ; Oblivion syntax
  ;        :ft :obse})
  (Plug "~/Programs_and_Stuff/Git_Repos/obse.vim")
  (Plug "~/Programs_and_Stuff/Git_Repos/obluavim")
  (Plug {1 :katawful/Obli-Vim-Docs
         :ft :obse}) ; OBSE docs
  (Plug {1 :SirVer/ultisnips
         :config (fn []
                   (require :plug/ultisnips))}) ; snippet engine
  (Plug :tpope/vim-commentary)  ; comment management
  (Plug :ggandor/lightspeed.nvim) ; lightspeed
  (Plug {1 :gelguy/wilder.nvim
         :config (fn []
                   (require :plug/wilder_con))})
  (Plug "~/Programs_and_Stuff/Git_Repos/syntax-test") ; syntax tester
  ; (Plug :hrsh7th/nvim-cmp) ; nvim-cmp
  ; (Plug :hrsh7th/cmp-nvim-lsp)
  ; (Plug {1 :nvim-telescope/telescope.nvim
  ;        :requires :nvim-lua/plenary.nvim
  ;        })

  ;; usability plugins
  (Plug {1 :junegunn/fzf
         :run (fn []
                (. vim.fn "fzf#install"))}) ; main FZF binary
  (Plug {1 :junegunn/fzf.vim
         :config (fn []
                   (require :plug/fzf_con))})   ; bindings for FZF in vim
  (Plug :tpope/vim-fugitive)   ; git management
  (Plug :airblade/vim-rooter)  ; puts vim to the root directory if possible

  ;; diary and wiki
  (Plug :mattn/calendar-vim)   ; calendar
  (Plug {1 :vimwiki/vimwiki
         :config (fn []
                   (require :plug/vimwiki))}); personal wiki
  (Plug {1 :nvim-neorg/neorg
         :branch :unstable
         :config (fn []
                   (require :plug/neorg_con))
         :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
  ; (Plug {1 "~/Programs_and_Stuff/Git_Repos/neorg"
  ;        :branch :code-regex-fallback
  ;        :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
  )
  :config {:display {:open_fn (. (require :packer.util) :float)}
           :compile_path (.. (vim.fn.stdpath :config )
                             "/lua/packer_compiled.lua")}
})

; tabby needs to load last for the colors to appear proper
((. (require :tabby) :setup))

; see if we need to compile packer
(if (= (checkForCompile) false)
  ((. (require :packer) :compile))
  )

;; compile non-fnl files
; after/ftplugin
(c.glob "*.fnl" "/home/kat/after/ftplugin" "/home/kat/after/ftplugin")
; plugin
(c.glob "*.fnl" "/home/kat/plugin" "/home/kat/plugin")
; autoload
(c.glob "*.fnl" "/home/kat/autoload" "/home/kat/autoload")
; ftplugin
(c.glob "*.fnl" "/home/kat/ftplugin" "/home/kat/ftplugin")
