(module init
        {require-macros [macros]})
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
           :run ":TSUpdate"})              ; tree-sitter main plugin
    (Plug :nvim-treesitter/playground)     ; view AST in real time
    (Plug :p00f/nvim-ts-rainbow)           ; color matching brackets
    (Plug :romgrk/nvim-treesitter-context) ; enhanced colors for embedded languages

    ;; aesthetics
    (Plug :akinsho/nvim-bufferline.lua)         ; buffer/tabline
    (Plug :hoob3rt/lualine.nvim)                ; statusline
    (Plug :junegunn/goyo.vim)                   ; readable windows
    (Plug :katawful/kat.vim)                    ; color
    (Plug :kyazdani42/nvim-web-devicons)        ; devicons
    (Plug :lukas-reineke/indent-blankline.nvim) ; fill in paragraph lines
    (Plug :mhinz/vim-startify)                  ; vim startscreen

    ;; editing plugins
    (Plug :lervag/vimtex)         ; LaTeX tools
    (Plug {1 :katawful/Obli-Vim
           :ft :obse})            ; oblivion script syntax and tools
    (Plug {1 :katawful/Obli-Vim-Docs
           :ft :obse})            ; OBSE docs
    (Plug :SirVer/ultisnips)      ; snippet engine
    (Plug :tpope/vim-commentary)  ; comment management

    ;; usability plugins
    (Plug {1 :junegunn/fzf
           :run (fn []
                  (. vim.fn "fzf#install"))}) ; main FZF binary
    (Plug :junegunn/fzf.vim)                  ; bindings for FZF in vim
    (Plug :tpope/vim-fugitive)                ; git management

    ;; diary and wiki
    (Plug :mattn/calendar-vim)                ; calendar
    (Plug :vimwiki/vimwiki)                   ; personal wiki
    (Plug {1 :vhyrro/neorg
           :requires :nvim-lua/plenary.nvim}) ; beta personal wiki
    {:display {:open_fn (. (require :packer.util) :float)}})

(require :config)
(require :au)
(require :maps)
(require :tshighlight)

(require :plug/core)
