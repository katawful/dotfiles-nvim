(module init
        {require-macros [macros]})
((. (require :packer) :startup) (fn [] 
    (Plug :wbthomason/packer.nvim)
    (Plug :Olical/aniseed)

    (Plug :katawful/kat.vim)
    (Plug :tpope/vim-fugitive)
    (Plug :lervag/vimtex)
    (Plug :SirVer/ultisnips)
    (Plug :vimwiki/vimwiki)
    (Plug {1 :junegunn/fzf
           :run (fn []
                  (. vim.fn "fzf#install"))})
    (Plug :junegunn/fzf.vim)
    (Plug :mhinz/vim-startify)
    (Plug :Yggdroot/indentLine)
    (Plug :tpope/vim-commentary)
    (Plug {1 :katawful/Obli-Vim
           :ft :obse})
    (Plug {1 :katawful/Obli-Vim-Docs
           :ft :obse})
    (Plug :mattn/calendar-vim)
    (Plug :bakpakin/fennel.vim)
    (Plug {1 :nvim-treesitter/nvim-treesitter
           :run ":TSUpdate"})
    (Plug :nvim-treesitter/playground)
    (Plug :hoob3rt/lualine.nvim)
    (Plug :kyazdani42/nvim-web-devicons)
    (Plug :akinsho/nvim-bufferline.lua)
    (Plug :p00f/nvim-ts-rainbow)
    (Plug :romgrk/nvim-treesitter-context)
    (Plug {1 :vhyrro/neorg
           :requires :nvim-lua/plenary.nvim})
    (Plug :lukas-reineke/indent-blankline.nvim))
    {:display {:open_fn (. (require :packer.util) :float)}})

(require :config)
(require :au)
(require :maps)

(require :plug.core)

