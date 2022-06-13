(module goyo
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

(let- g :goyo_width 120)
(nno- :<leader>Gy ":Goyo<CR>" "Activate Goyo")
