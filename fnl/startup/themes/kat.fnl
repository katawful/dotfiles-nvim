(let [settings {:header {:type :text
                         :align :center
                         :fold_section false
                         :title :Header
                         :margin 5
                         :content (. (require :startup.headers)
                                     :neovim_logo_header)
                         :highlight :Statement
                         :default_color ""
                         :oldfiles_amount 0}
                :header_2 {:type :text
                           :oldfiles_directory false
                           :align :center
                           :fold_section false
                           :title :Quote
                           :margin 5
                           :content (. (require :startup.functions) :quote)
                           :highlight :Constant
                           :default_color ""
                           :oldfiles_amount 0}
                :body {:type :mapping
                       :align :center
                       :fold_section false
                       :title "Basic Commands"
                       :margin 5
                       :content {1 {1 " Find File"
                                    2 "lua require('plug.fzf_con').files()"
                                    3 :<leader>f}
                                 2 {1 " Find Word"
                                    2 "Telescope live_grep"
                                    3 :<leader>lg}
                                 3 {1 " Recent Files"
                                    2 "Telescope oldfiles"
                                    3 :<leader>of}
                                 4 {1 " File Browser"
                                    2 "Telescope file_browser"
                                    3 :<leader>fb}
                                 5 {1 " Colorschemes"
                                    2 "Telescope colorscheme"
                                    3 :<leader>cs}
                                 6 {1 " New File"
                                    2 "lua require'startup'.new_file()"
                                    3 :<leader>nf}}
                       :highlight :String
                       :default_color ""
                       :oldfiles_amount 0}
                :body_2 {:type :oldfiles
                         :oldfiles_directory true
                         :align :center
                         :fold_section false
                         :title (.. "Recent files in: " (vim.fn.getcwd))
                         :margin 5
                         :content {1 :NNNNN}
                         :highlight :Constant
                         :default_color "#FFFFFF"
                         :oldfiles_amount 5}
                :footer {:type :oldfiles
                         :oldfiles_directory false
                         :align :center
                         :fold_section false
                         :title :Oldfiles
                         :margin 5
                         :content {1 :startup.nvim}
                         :highlight :TSString
                         :default_color "#FFFFFF"
                         :oldfiles_amount 5}
                :clock {:type :text
                        :content (fn []
                                   (local clock (.. " " (os.date "%H:%M")))
                                   (local date (.. " " (os.date "%d-%m-%y")))
                                   {1 clock 2 date})
                        :oldfiles_directory false
                        :align :center
                        :fold_section false
                        :title ""
                        :margin 5
                        :highlight :TSString
                        :default_color "#FFFFFF"
                        :oldfiles_amount 10}
                :footer_2 {:type :text
                           :content ((. (require :startup.functions)
                                        :packer_plugins))
                           :oldfiles_directory false
                           :align :center
                           :fold_section false
                           :title ""
                           :margin 5
                           :highlight :TSString
                           :default_color "#FFFFFF"
                           :oldfiles_amount 10}
                :options {:after (fn []
                                   ((. (require :startup.utils)
                                       :oldfiles_mappings)))
                          :mapping_keys true
                          :cursor_column 0.5
                          :empty_lines_between_mappings true
                          :disable_statuslines true
                          :paddings {1 2 2 2 3 2 4 2 5 2 6 2 7 2}}
                :colors {:background "#1f2227" :folded_section "#56b6c2"}
                :parts {1 :header
                        2 :header_2
                        3 :body
                        4 :body_2
                        5 :footer
                        6 :clock
                        7 :footer_2}}]
  settings)
