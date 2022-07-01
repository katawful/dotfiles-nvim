(module plugins.treesitter.config
        {require-macros [katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.maps.macros]})

;;; Configs for tree-sitter

;; Install norg parsers
(var parser-configs (opt- :nvim-treesitter.parsers :get_parser_configs))
(set parser-configs.norg
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                     :files {1 :src/parser.c 2 :src/scanner.cc}
                     :branch :main}})

(set parser-configs.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files {1 :src/parser.c}
                     :branch :main}})

(set parser-configs.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files {1 :src/parser.c}
                     :branch :main}})

;; Seq -- sequential table of languages
(def- languages [:query
                 :norg
                 :norg_meta
                 :norg_table
                 :fennel
                 :lua
                 :html
                 :css
                 :cpp
                 :c
                 :bash
                 :javascript
                 :markdown
                 :markdown_inline])

;; Setup -- setup table for nvim-treesitter
;; https://github.com/nvim-treesitter/nvim-treesitter
(opt- :nvim-treesitter.configs :setup
      {:ensure_installed languages
       :highlight {:enable true}
       :indent {:enable true}
       :incremental_selection {:enable true
                               :keymaps {:init_selection :gnn
                                         :node_decremental :grm
                                         :node_incremental :grn
                                         :scope_incremental :grc}}})
