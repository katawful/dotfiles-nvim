(module core)

((. (require :bufferline) :setup))
; ((. (require :nvim-treesitter.configs) :setup))

(require :plug.lualine_con)
(require :plug.bufferline)
(require :plug.indentline)

((. (require :neorg) :setup))
(require :plug.neorg)

(require :plug.playground)
(require :plug.treesitter)

(require :plug.startify)

(require :plug.fzf)
(require :plug.ultisnips)

(require :plug.vimtex)
(require :plug.vimwiki)
(require :plug.oblivim)
