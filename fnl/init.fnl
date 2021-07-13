(module init
	{require-macros [macros]})

; vimwiki stuff
(let- g :vimwiki_lists 
  {1 {:path "~/Documents/VimwikiHTML/Vimwiki"
      :path_html "~/Documents/VimWikiHTML"
      :auto_generate_links 1
      :auto_export 1}})

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
    (Plug :hoob3rt/lualine.nvim)
    (Plug :kyazdani42/nvim-web-devicons)
    (Plug :akinsho/nvim-bufferline.lua)
    (Plug :p00f/nvim-ts-rainbow)
    (Plug :romgrk/nvim-treesitter-context)))

(require :config)
(require :au)
(require :maps)

(require :plug.core)

