(module plugins.vimwiki.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for vimwiki

(nno- :<leader>W<leader>W ":VimwikiDiaryIndex<CR>" "Open Vimwiki diary")
(nno- :<leader>ww ":VimwikiIndex<CR>" "Open Vimwiki index")
