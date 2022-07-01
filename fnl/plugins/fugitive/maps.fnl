(module plugins.fugitive.maps {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for vim-fugitive

;; String -- leader key for how fugitive should be subkeyed
(defonce- gitLeader :G)

;; FN -- create a single mode map using the fugitive leader key
;; @mode -- mode to use
;; @lhs -- left hand side
;; @rhs -- right hand side
;; @description -- description for mapping
(defn fugMap [mode lhs rhs description]
      (match mode
        :n (do
             (nno- (.. :<leader> gitLeader lhs) rhs
                   {:desc description :silent true :nowait true}))))

(fugMap :n :g :<cmd>Git<CR> "Open Fugitive window")
(fugMap :n :p "<cmd>Git push<CR>" "Push commits of current repo")
