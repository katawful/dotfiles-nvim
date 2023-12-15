(module plugins.neogit.maps
        {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for Neogit

;; String -- neogit leader subkey
(defonce- gitLeader :g)

;; Module -- neogit module
(defonce- neogit (require :neogit))

;; FN -- create a single mode map using the Neogit leader key
;; @mode -- mode to use
;; @lhs -- left hand side
;; @rhs -- right hand side
;; @description -- description for mapping
(defn map [mode lhs rhs description]
      (match mode
        :n (do
             (nno- (.. :<leader> gitLeader lhs) rhs
                   {:desc description :silent true :nowait true}))))

(map :n :g (fn [] (neogit.open {:kind :split_above})) "Open Neogit window")
