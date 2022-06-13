(module vimwiki
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

(nno- :<leader>W<leader>W ":VimwikiDiaryIndex<CR>" "Open Vimwiki diary")
(nno- :<leader>ww ":VimwikiIndex<CR>" "Open Vimwiki index")

; ALL VIMWIKI CONFIGS IS IN BEFORE.VIM
; IT MUST LOAD VERY EARLY TO WORK
