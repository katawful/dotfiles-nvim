(module plugins.treesitter.playground.maps {require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Maps for playground

; show highlight
(nno- :<Leader>h ":TSHighlightCapturesUnderCursor<CR>"
      "Show highlight under cursor")
