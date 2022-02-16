(module treesitter-doc
  {require-macros [macros]})

(opt- nvim-treesitter.configs setup 
      {:tree_docs {:enable false}})
