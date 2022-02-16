(module fugitive
  {require-macros [macros]})

(def- gitLeader :G)

(defn fugMap [mode lhs rhs]
  (match mode
    :n (do
         (nno- (.. :<leader> gitLeader lhs) rhs :silent :nowait))))

(fugMap :n :g "<cmd>Git<CR>")
(fugMap :n :p "<cmd>Git push<CR>")
