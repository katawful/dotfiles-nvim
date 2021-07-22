(module neorg
        {require-macros [macros]})

(opt- neorg setup
 {:load {:core.defaults {}
         :core.norg.concealer {}
         :core.keybinds {:config {
            :default_keybinds true
            :neorg_leader :<Leader>n}}
         :core.norg.dirman {
            :config {:workspaces {:my_workspace "~/neorg"}
                     :autodetect true
                     :autochdir true}}}})

(var parser-configs (opt- nvim-treesitter.parsers get_parser_configs))
(set parser-configs.norg
  {:install_info {:url "https://github.com/vhyrro/tree-sitter-norg"
                        :files {1 :src/parser.c}
                        :branch :main}})
