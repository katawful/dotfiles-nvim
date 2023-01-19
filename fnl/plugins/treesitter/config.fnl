(module plugins.treesitter.config
        {autoload {sys system}
         require-macros [katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.maps.macros]})

;;; Configs for tree-sitter

;; Install norg parsers
(var parser-configs (opt- :nvim-treesitter.parsers :get_parser_configs))

(set parser-configs.obl
     {:install_info {:url "/home/kat/tree-sitter-obl/"
                     :files [:src/parser.c :src/scanner.cc]
                     :branch :main
                     :require_generate_from_grammar true}
      :filetype :obl})

(vim.filetype.add 
  {:extension {:obl :obl}
   :pattern {".*.obl" :obl
              ".*.obse" :obl
              ".*.obscript" :obl}})

;; Seq -- sequential table of languages
(def- languages [:query
                 :clojure
                 :gitattributes
                 :zig
                 :python
                 :fennel
                 :lua
                 :html
                 :css
                 :cpp
                 :c
                 :latex
                 :vim
                 :bash
                 :javascript
                 :markdown
                 :markdown_inline])

(if (not= sys.name :builder)
    (table.insert languages :obl))

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
