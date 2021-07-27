(module jobs
        {require-macros [macros]})

(fn _G.lazyGitUpdate []
  (com- Git "add -u")
  (com- Git "commit -m 'update'")
  (com- Git push))

{: lazyGitUpdate}
