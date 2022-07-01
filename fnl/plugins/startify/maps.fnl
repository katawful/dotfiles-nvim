(module plugins.startify.maps
        {autoload {runners plugins.startify.runners}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for startify

(nno- :<leader>sn (fn []
                    (runners.kat-start :none))
      "Open Startify in window")

(nno- :<leader>ss (fn []
                    (runners.kat-start :hor))
      "Open Startify in split")

(nno- :<leader>sv (fn []
                    (runners.kat-start :ver))
      "Open Startify in vsplit")

(nno- :<leader>st (fn []
                    (runners.kat-start :tab))
      "Open Startify in tab")
