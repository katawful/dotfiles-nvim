(module core
        {require-macros [macros]})

; setup configs that need to be here
(opt- bufferline setup)
(opt- neorg setup)

(require :plug/lualine_con)
(require :plug/bufferline)
(require :plug/indentline)
(require :plug/conjure)
(require :plug/goyo)

(require :plug/neorg)

(require :plug/playground)
(require :plug/treesitter)

(require :plug/vimwiki)
(require :plug/startify)

(require :plug/fzf)
(require :plug/ultisnips)

(require :plug/vimtex)
(require :plug/oblivim)
