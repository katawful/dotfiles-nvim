(module init
  {require-macros [katcros-fnl.macros.nvim.packer.macros
                   katcros-fnl.macros.nvim.api.options.macros]
   autoload {c aniseed.compile
             s aniseed.string}})


; call global settings
(require :au)
(require :config)
(require :maps)
(set- termguicolors true)
(let- :g :kat_nvim_dontRender true)
(let- :g :kat_nvim_compile_enable false)

; check if our compiled packer file exists and source it
(defn checkForCompile []
  (let [file (io.open "/home/kat/lua/packer_compiled.lua" "r")]
    (if (not= file nil)
      (do
        (io.close file)
        (require :packer_compiled))
      (do false))))
(checkForCompile)

((. (require :packer) :startup)
 {1 (fn [use]

      ;; bootstrap stuff
      (Plug "~/Programs_and_Stuff/Git_Repos/katcros-fnl/")
      ; (Plug "katawful/katcros-fnl")
      (Plug :wbthomason/packer.nvim)   ; plugin manager
      (Plug :Olical/aniseed)           ; fennel environment
      (Plug :lewis6991/impatient.nvim) ; faster loading

      (Plug {1 :rcarriga/nvim-notify
             :config (fn []
                       (set vim.notify (require :notify))
                       (vim.notify.setup {:stages :slide}))})

      ;; fennel dev
      ; REPL tools
      (Plug {1 :Olical/conjure
             :tag :v4.35.1})
      ; (Plug {1 :bakpakin/fennel.vim
      ;        :ft :fennel}) ; enhanced regex syntax highlight

      ;; treesitter
      (Plug {1 :nvim-treesitter/nvim-treesitter
             :run ":TSUpdate"
             :config (fn []
                       (require :plug/treesitter))})
      ; tree-sitter main plugin
      (Plug {1 :nvim-treesitter/playground
             :config (fn []
                       (require :plug/playground))}) ; view AST in real time
      (Plug {1 :p00f/nvim-ts-rainbow
             :config (fn []
                       (require :plug/rainbow_con))}) ; color matching brackets
      (Plug {1 :romgrk/nvim-treesitter-context
             :config (fn []
                       (require :plug/treesitter-context_con))}) ; enhanced colors for embedded languages
      (Plug {1 :nvim-treesitter/nvim-tree-docs
             :config (fn []
                       (require :plug/treesitter-doc))})

      (Plug {1 :SmiteshP/nvim-gps
             :config (fn []
                       (require :plug/nvim-gps_con))}) ; TS cursor location

      ;; lsp
      (Plug {1 :neovim/nvim-lspconfig
             :requires :williamboman/nvim-lsp-installer})
             ; :config (fn []
             ;           (require :plug/lspconfig_con)
             ;           (_G.install_servers))})

      (Plug {1 "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
             :config (fn []
                       (require :plug/lsp_lines_con))})


      ;; aesthetics
      (Plug :katawful/kat.vim) ; vimscript colorscheme
      (Plug "~/Programs_and_Stuff/Git_Repos/katdotnvim/")

      (Plug {1 :nanozuki/tabby.nvim})
             ; :config (fn []
             ;           (require :plug/tabby_con))})
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
      ; (Plug {1 :startup-nvim/startup.nvim
      ;        :config (fn []
      ;                  (require :plug/startup-con))})
      ; (Plug {1 :mhinz/vim-startify
      ;        :config (fn []
      ;                  (require :plug/startify))}); vim startscreen

      (Plug {1 "~/Programs_and_Stuff/Git_Repos/vim-startify/"
             :config (fn []
                       (require :plug/startify))}); vim startscreen
      (Plug :andweeb/presence.nvim)               ; discord presence

      ;; editing plugins
      (Plug {1 :gpanders/nvim-parinfer})
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
      ; (Plug :ggandor/lightspeed.nvim) ; lightspeed
      (Plug {1 :gelguy/wilder.nvim
             :config (fn []
                       (require :plug/wilder_con))}) ; completion for command line and search
      (Plug "~/Programs_and_Stuff/Git_Repos/syntax-test") ; syntax tester
      (Plug "~/Programs_and_Stuff/Git_Repos/kreative") ; syntax tester
      ; (Plug {1 :hrsh7th/nvim-cmp
      ;        :config (fn []
      ;                  (require :plug/nvim-cmp_con))}) ; nvim-cmp
      (Plug :vim-scripts/bnf.vim)
      (Plug :killphi/vim-ebnf)
      ; (Plug :hrsh7th/cmp-nvim-lsp)
      ; (Plug {1 :nvim-telescope/telescope.nvim
      ;        :requires :nvim-lua/plenary.nvim
      ;        })

      ;; usability plugins
      (Plug {1 :junegunn/fzf
             :run "./install --all"}) ; main FZF binary
      ; (Plug {1 :junegunn/fzf.vim
      ;        :config (fn []
      ;                  (require :plug/fzf_con))})   ; bindings for FZF in vim
      (Plug :elihunter173/dirbuf.nvim)
      (Plug {1 :ibhagwan/fzf-lua
             :requires :vijaymarupudi/nvim-fzf
             :config (fn []
                       (require :plug/fzf_con))})

      (Plug {1 :tpope/vim-fugitive
             :config (fn []
                       (require :plug/fugitive))})
      ; git management
      (Plug :airblade/vim-rooter) ; rooter

      ;; diary and wiki
      (Plug :mattn/calendar-vim)   ; calendar
      (Plug {1 :vimwiki/vimwiki
             :config (fn []
                       (require :plug/vimwiki))}); personal wiki
      ; (Plug {1 "~/Programs_and_Stuff/Git_Repos/neorg"
      ;        :config (fn []
      ;                  (require :plug/neorg_con))
      ;        :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
      (Plug {1 :nvim-neorg/neorg
             :branch :main
             :config (fn []
                       (require :plug/neorg_con))
             :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
      ; (Plug {1 "~/Programs_and_Stuff/Git_Repos/neorg"
               ;        :branch :code-regex-fallback
               ;        :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
      (Plug :psliwka/termcolors.nvim))
      ; (Plug "~/Programs_and_Stuff/Git_Repos/test-fennel/"))

  :config {:display {:open_fn (. (require :packer.util) :float)}
           :compile_path (.. (vim.fn.stdpath :config)
                             "/lua/packer_compiled.lua")}})

;; compile non-fnl files
; after/ftplugin
(c.glob "*.fnl" "/home/kat/after/ftplugin" "/home/kat/after/ftplugin")
; plugin
(c.glob "*.fnl" "/home/kat/plugin" "/home/kat/plugin")
; autoload
(c.glob "*.fnl" "/home/kat/autoload" "/home/kat/autoload")
; ftplugin
(c.glob "*.fnl" "/home/kat/ftplugin" "/home/kat/ftplugin")

((. (require :plug/colorscheme) :set*))

; see if we need to compile packer
(if (= (checkForCompile) false)
  ((. (require :packer) :compile)))

; tabby needs to load last for the colors to appear proper
; ((. (require :tabby) :setup))
; (require :plug/tabby_con)

