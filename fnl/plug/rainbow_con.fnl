(module rainbow_con
  {require-macros [katcros-fnl.macros.lispism.macros]})

(opt- :nvim-treesitter.configs :setup {
                                       :rainbow {
                                                 :enable true
                                                 :extended_mode true
                                                 :max_file_lines 1000}})
