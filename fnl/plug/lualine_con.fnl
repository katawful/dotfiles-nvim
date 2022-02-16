(module lualine_con
        {require-macros [macros]
         require {gps nvim-gps}
         })

(opt- lualine setup
      { :options {
                  :icons_enabled 1
                  :theme :kat
                  :component_separators {:left ""
                                         :right ""}
                  :section_separators {:left ""
                                       :right ""}
                  :disabled_filetypes {}
                  :always_divide_middle true
                  }
       :sections  {
                   :lualine_a {1 :mode}
                   :lualine_b {1 :branch}
                   :lualine_c {1 {1 :filename
                                  :file_status true
                                  :path 1}}
                   :lualine_x {1 {1 :filetype 
                                  :colored true}}
                               ; 2 {1 gps.get_location
                               ;    :cond gps.is_available}}
                               
                   :lualine_y {1 :progress
                               2 :fileformat
                               }
                   :lualine_z {1 :location}}
       :inactive_sections  {
                            :lualine_a {}
                            :lualine_b {}
                            :lualine_c {1 :filename}
                            :lualine_x {1 :location}
                            :lualine_y {}
                            :lualine_z {}}
       :tabline {}
       :extensions {1 :fzf
                    2 :fugitive}})

