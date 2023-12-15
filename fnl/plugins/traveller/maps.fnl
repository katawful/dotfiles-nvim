(module plugins.traveller.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

(def- traveller (require :nvim-traveller))

(nno- "-" traveller.open_navigation "Open Traveller window")
