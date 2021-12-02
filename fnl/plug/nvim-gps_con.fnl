(module nvim-gps_con
        {require-macros [macros]})

(opt- nvim-gps setup
      {:icons {:class-name " "
               :function-name " "
               :method-name " "}
       :languages {:javascript true
                   :lua true
                   :fennel true
                   :bash true}
       :separator " > "})

; (def- gps (require :nvim-gps))
; (opt- lualine setup
;       {:sections {:lualine_x {4 {1 gps.get_location
;                                  :condition gps.is_available}}}})
