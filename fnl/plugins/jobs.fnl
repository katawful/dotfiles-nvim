(module jobs
        {require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

(fn _G.lazyGitUpdate []
  (com- Git "add -u")
  (com- Git "commit -m 'update'")
  (com- Git push))

{: lazyGitUpdate}
