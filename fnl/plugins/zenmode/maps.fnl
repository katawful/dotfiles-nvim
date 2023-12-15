(module plugins.zenmode.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})


(nno- :<leader>Gy (fn [] ((. (require :zen-mode) :toggle))) "Activate zen mode")
