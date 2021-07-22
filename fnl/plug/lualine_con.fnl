(module lualine_con
        {require-macros [macros]})

; (fn luaTablineBuffers []
;   ; store buffer
;   (let [currBuffs (vim.api.nvim_list_bufs)
;         output []]
;     ; work through each buffer
;     (each [k v (ipairs currBuffs)]
;       ; if loaded, store to new table
;       (if (= (vim.api.nvim_buf_is_loaded v) true)
;         (table.insert output k (vim.api.nvim_buf_get_name v))))
;     (each [k v (pairs output)]

; (luaTablineBuffers)

(opt- lualine setup
      { :options {
                  :icons_enabled 1
                  :theme :kat
                  :component_separators {1 "" 
                                         2 ""}
                  :section_separators {1 ""
                                       2 ""}
                  :disabled_filetypes {}}
       :sections  {
                   :lualine_a {1 :mode}
                   :lualine_b {1 :branch}
                   :lualine_c {1 {1 :filename
                                  :file_status true
                                  :path 1}}
                   :lualine_x {1 :encoding
                               2 :fileformat
                               3 {1 :filetype 
                                  :colored true}}
                   :lualine_y {1 :progress}
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

