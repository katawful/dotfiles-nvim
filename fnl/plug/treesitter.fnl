(module treesitter)

((. (require :nvim-treesitter.configs) :setup) {
  :ensure_installed :maintained
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
  })
