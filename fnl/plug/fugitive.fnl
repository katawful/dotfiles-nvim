(module fugitive
  {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

(def- gitLeader :G)

(defn fugMap [mode lhs rhs description]
  (match mode
    :n (do
         (nno- (.. :<leader> gitLeader lhs) rhs {:desc description
                                                 :silent true
                                                 :nowait true}))))

(fugMap :n :g "<cmd>Git<CR>" "Open Fugitive window")
(fugMap :n :p "<cmd>Git push<CR>" "Push commits of current repo")
