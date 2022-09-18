(module neorg
        {autoload {neorg plugins.neorg.gtd}
         require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.utils.macros
                         katcros-fnl.macros.nvim.api.maps.macros]})

(set-opts-auto {tabstop 2
                shiftwidth 2
                expandtab true
                textwidth 100
                spell true
                listchars {:tab "  " :extends ">" :precedes "<"}
                wrap false
                concealcursor :nvc})

(let [gtd-change (def-command :KatGTDChange
                              (fn []
                                (neorg.change-gtd-workspace)
                                (neorg.reload-gtd))
                              "Switches to current GTD module")]
  (do-command gtd-change))

(nno- :<leader>to :<cmd>NvimTreeFocus<CR> "Focus nvim tree" {:buffer true})
(nno- :<leader>tc :<cmd>NvimTreeClose<CR> "Close nvim tree" {:buffer true})
(nno- :<leader>tt :<cmd>NvimTreeToggle<CR> "Toggle nvim tree" {:buffer true})
