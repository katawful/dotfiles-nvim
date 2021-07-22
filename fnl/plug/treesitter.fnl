(module treesitter
        {require-macros [macros]})

(opt- nvim-treesitter.configs setup {
  :ensure_installed {1 :norg
                     2 :bash
                     3 :javascript
                     4 :fennel
                     5 :lua}
  :highlight {:enable true}
  :indent {:enable true}
  :incremental_selection {
                          :enable true
                          :keymaps {
                                    :init_selection :gnn
                                    :node_decremental :grm
                                    :node_incremental :grn
                                    :scope_incremental :grc}
                          }
  :rainbow {
            :enable true
            :extended_mode true
            :max_file_lines 1000}
  })

(opt- treesitter-context.config setup
 {:enable true})

(vim.cmd "hi TreesitterContext guibg=#2c466e")
