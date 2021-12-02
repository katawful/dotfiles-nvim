(module core
        {require-macros [macros]})

; setup configs that need to be here
; (opt- tabby setup)
; (opt- bufferline setup)
(opt- neorg setup)
; (opt- nvim-gps setup)
; ((. (require :obluavim.main) :init))

; (require :plug/lspconfig_con)
; (require :plug/lualine_con)
; (require :plug/bufferline)
(require :plug/indentline)
(require :plug/conjure)
(require :plug/goyo)
; (require :plug/nvim-gps)

; (require :plug/playground)

(require :plug/neorg_con)

; (require :plug/treesitter)

(require :plug/vimwiki)
(require :plug/startify)

(require :plug/fzf)
(require :plug/ultisnips)

(require :plug/vimtex)
(require :plug/oblivim)
(require :plug/wilder_con)
