(module plugins.neogit.config
        {autoload {colors katdotnvim.color
                   render katdotnvim.utils.export.render}
         require-macros [katcros-fnl.macros.nvim.api.utils.macros]})

;;; Configs for Neogit
;;; https://github.com/NeogitOrg/neogit

((. (require :neogit) :setup) {})

(def- color colors.kat)
(def- red color.red)
(def- pink color.pink)
(def- blue color.blue)
(def- green color.green)
(def- purple color.purple)
(def- orange color.orange)
(def- teal color.teal)
(def- plum color.plum)
(def- fg color.fg)
(def- bg color.bg)

(defn overrides []
  (render.override {:source "neogit"
                    :light_hard [{:group :NeogitGraphRed :fg red.base.color}
                                 {:group :NeogitGraphBoldRed :fg red.base.color :bold true}
                                 {:group :NeogitGraphWhite :fg fg.base.color}
                                 {:group :NeogitGraphBoldWhite :fg fg.base.color :bold true}
                                 {:group :NeogitGraphOrange :fg orange.base.color}
                                 {:group :NeogitGraphBoldOrange :fg orange.base.color :bold true}
                                 {:group :NeogitGraphYellow :fg orange.match_fg.color}
                                 {:group :NeogitGraphBoldYellow :fg orange.match_fg.color :bold true}
                                 {:group :NeogitGraphGreen :fg green.auto.color}
                                 {:group :NeogitGraphBoldGreen :fg green.auto.color :bold true}
                                 {:group :NeogitGraphCyan :fg blue.match_fg.color}
                                 {:group :NeogitGraphBoldCyan :fg blue.match_fg.color :bold true}
                                 {:group :NeogitGraphBlue :fg blue.base.color}
                                 {:group :NeogitGraphBoldBlue :fg blue.base.color :bold true}
                                 {:group :NeogitGraphPurple :fg purple.base.color}
                                 {:group :NeogitGraphBoldPurple :fg purple.base.color :bold true}
                                 {:group :NeogitGraphGray :fg fg.meld.color}
                                 {:group :NeogitGraphBoldGray :fg fg.meld.color :bold true}
                                 {:group :NeogitDiffAdd :link :DiffAdd}
                                 {:group :NeogitDiffDelete :link :DiffDelete}
                                 {:group :NeogitDiffContext :link :DiffText}
                                 {:group :NeogitDiffAddHighlight :link :diffAdded}
                                 {:group :NeogitDiffDeleteHighlight :link :diffRemoved}
                                 {:group :NeogitDiffContextHighlight :link :diffText}
                                 {:group :NeogitHunkHeader :fg fg.base.color :bg bg.shadow.color}
                                 {:group :NeogitHunkHeaderHighlight :fg fg.base.color :bg bg.umbra.color}]})
  (render.override {:source "neogit"
                    :light_soft [{:group :NeogitGraphRed :fg red.base.color}
                                 {:group :NeogitGraphBoldRed :fg red.base.color :bold true}
                                 {:group :NeogitGraphWhite :fg fg.base.color}
                                 {:group :NeogitGraphBoldWhite :fg fg.base.color :bold true}
                                 {:group :NeogitGraphOrange :fg orange.base.color}
                                 {:group :NeogitGraphBoldOrange :fg orange.base.color :bold true}
                                 {:group :NeogitGraphYellow :fg orange.match_fg.color}
                                 {:group :NeogitGraphBoldYellow :fg orange.match_fg.color :bold true}
                                 {:group :NeogitGraphGreen :fg green.auto.color}
                                 {:group :NeogitGraphBoldGreen :fg green.auto.color :bold true}
                                 {:group :NeogitGraphCyan :fg blue.match_fg.color}
                                 {:group :NeogitGraphBoldCyan :fg blue.match_fg.color :bold true}
                                 {:group :NeogitGraphBlue :fg blue.base.color}
                                 {:group :NeogitGraphBoldBlue :fg blue.base.color :bold true}
                                 {:group :NeogitGraphPurple :fg purple.base.color}
                                 {:group :NeogitGraphBoldPurple :fg purple.base.color :bold true}
                                 {:group :NeogitGraphGray :fg fg.meld.color}
                                 {:group :NeogitGraphBoldGray :fg fg.meld.color :bold true}
                                 {:group :NeogitDiffAdd :link :DiffAdd}
                                 {:group :NeogitDiffDelete :link :DiffDelete}
                                 {:group :NeogitDiffContext :link :DiffText}
                                 {:group :NeogitDiffAddHighlight :link :diffAdded}
                                 {:group :NeogitDiffDeleteHighlight :link :diffRemoved}
                                 {:group :NeogitDiffContextHighlight :link :diffText}
                                 {:group :NeogitHunkHeader :fg fg.base.color :bg bg.shadow.color}
                                 {:group :NeogitHunkHeaderHighlight :fg fg.base.color :bg bg.umbra.color}]})
  (render.override {:source "neogit"
                    :dark_hard  [{:group :NeogitGraphRed :fg red.base.color}
                                 {:group :NeogitGraphBoldRed :fg red.base.color :bold true}
                                 {:group :NeogitGraphWhite :fg fg.base.color}
                                 {:group :NeogitGraphBoldWhite :fg fg.base.color :bold true}
                                 {:group :NeogitGraphOrange :fg orange.base.color}
                                 {:group :NeogitGraphBoldOrange :fg orange.base.color :bold true}
                                 {:group :NeogitGraphYellow :fg orange.match_fg.color}
                                 {:group :NeogitGraphBoldYellow :fg orange.match_fg.color :bold true}
                                 {:group :NeogitGraphGreen :fg green.auto.color}
                                 {:group :NeogitGraphBoldGreen :fg green.auto.color :bold true}
                                 {:group :NeogitGraphCyan :fg blue.match_fg.color}
                                 {:group :NeogitGraphBoldCyan :fg blue.match_fg.color :bold true}
                                 {:group :NeogitGraphBlue :fg blue.base.color}
                                 {:group :NeogitGraphBoldBlue :fg blue.base.color :bold true}
                                 {:group :NeogitGraphPurple :fg purple.base.color}
                                 {:group :NeogitGraphBoldPurple :fg purple.base.color :bold true}
                                 {:group :NeogitGraphGray :fg fg.meld.color}
                                 {:group :NeogitGraphBoldGray :fg fg.meld.color :bold true}
                                 {:group :NeogitDiffAdd :link :DiffAdd}
                                 {:group :NeogitDiffDelete :link :DiffDelete}
                                 {:group :NeogitDiffContext :link :DiffText}
                                 {:group :NeogitDiffAddHighlight :link :diffAdded}
                                 {:group :NeogitDiffDeleteHighlight :link :diffRemoved}
                                 {:group :NeogitDiffContextHighlight :link :diffText}
                                 {:group :NeogitHunkHeader :fg fg.base.color :bg bg.shadow.color}
                                 {:group :NeogitHunkHeaderHighlight :fg fg.base.color :bg bg.umbra.color}]})
  (render.override {:source "neogit"
                    :dark_soft  [{:group :NeogitGraphRed :fg red.base.color}
                                 {:group :NeogitGraphBoldRed :fg red.base.color :bold true}
                                 {:group :NeogitGraphWhite :fg fg.base.color}
                                 {:group :NeogitGraphBoldWhite :fg fg.base.color :bold true}
                                 {:group :NeogitGraphOrange :fg orange.base.color}
                                 {:group :NeogitGraphBoldOrange :fg orange.base.color :bold true}
                                 {:group :NeogitGraphYellow :fg orange.match_fg.color}
                                 {:group :NeogitGraphBoldYellow :fg orange.match_fg.color :bold true}
                                 {:group :NeogitGraphGreen :fg green.auto.color}
                                 {:group :NeogitGraphBoldGreen :fg green.auto.color :bold true}
                                 {:group :NeogitGraphCyan :fg blue.match_fg.color}
                                 {:group :NeogitGraphBoldCyan :fg blue.match_fg.color :bold true}
                                 {:group :NeogitGraphBlue :fg blue.base.color}
                                 {:group :NeogitGraphBoldBlue :fg blue.base.color :bold true}
                                 {:group :NeogitGraphPurple :fg purple.base.color}
                                 {:group :NeogitGraphBoldPurple :fg purple.base.color :bold true}
                                 {:group :NeogitGraphGray :fg fg.meld.color}
                                 {:group :NeogitGraphBoldGray :fg fg.meld.color :bold true}
                                 {:group :NeogitDiffAdd :link :DiffAdd}
                                 {:group :NeogitDiffDelete :link :DiffDelete}
                                 {:group :NeogitDiffContext :link :DiffText}
                                 {:group :NeogitDiffAddHighlight :link :diffAdded}
                                 {:group :NeogitDiffDeleteHighlight :link :diffRemoved}
                                 {:group :NeogitDiffContextHighlight :link :diffText}
                                 {:group :NeogitHunkHeader :fg fg.base.color :bg bg.shadow.color}
                                 {:group :NeogitHunkHeaderHighlight :fg fg.base.color :bg bg.umbra.color}]}))

(cre-command "KatNeogitOverride" overrides "Add color overrides")

;; Call maps
(require :plugins.neogit.maps)
