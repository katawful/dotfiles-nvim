(module plugins.zenmode.config
         {require-macros [katcros-fnl.macros.lispism.macros]})

((. (require :zen-mode) :setup) {:window {:width 140}
                                 :plugins {:options {:ruler true}}})

(require :plugins.zenmode.maps)
