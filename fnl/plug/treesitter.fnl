(module treesitter
        {require-macros [macros]})

(var parser-configs (opt- nvim-treesitter.parsers get_parser_configs))
(set parser-configs.norg
  {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                        :files {1 :src/parser.c
                                2 :src/scanner.cc}
                        :branch :main}})
(opt- nvim-treesitter.configs setup {
  :ensure_installed {1 :norg
                     2 :bash
                     3 :javascript
                     4 :fennel
                     5 :lua
                     6 :html
                     7 :css
                     8 :cpp
                     9 :c
                     }
  :highlight {:enable true
              }
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

; show highlight
(nno- :<Leader>h ":TSHighlightCapturesUnderCursor<CR>")

