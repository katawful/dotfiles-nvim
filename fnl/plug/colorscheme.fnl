(module colorscheme
  {require-macros [katcros-fnl.macros.nvim.api.options.macros
                   katcros-fnl.macros.nvim.api.colors.macros]})

(defn set* []
  (let [timeLocal (tonumber (vim.fn.strftime "%H"))]
    ; (let- :g :kat_nvim_stupidFeatures true)
    (let- :g :kat_nvim_integrations
      [:lsp
       :treesitter
       :ts_rainbow
       :indent_blankline
       :startify
       :coc
       :cmp
       :fugitive])
    (if (and (> timeLocal 18)
             (<= timeLocal 8))
      (do
        (set vim.o.background :dark)
        (col- "kat.nvim"))
      (and (> timeLocal 8)
           (<= timeLocal 12))
      (do
        (set vim.o.background :light)
        (col- "kat.nwim"))
      (and (> timeLocal 12)
           (<= timeLocal 15))
      (do
        (set vim.o.background :light)
        (col- "kat.nvim"))
      (and (> timeLocal 15)
           (<= timeLocal 18))
      (do
        (set vim.o.background :dark)
        (col- "kat.nwim"))
      (do
        (set vim.o.background :dark)
        (col- "kat.nvim")))))
