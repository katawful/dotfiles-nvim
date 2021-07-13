(module vimwiki
        {require-macros [macros]})

(nno- :<leader>W<leader>W ":VimwikiDiaryIndex<CR>")
(nno- :<leader>ww ":VimwikiIndex<CR>")

; ALL VIMWIKI CONFIGS IS IN BEFORE.VIM
; IT MUST LOAD VERY EARLY TO WORK
