(module colorscheme)

(defn scheme []
  (let [timeLocal (tonumber (vim.fn.strftime "%H"))]
    (if (and (> timeLocal 20)
             (<= timeLocal 8))
        (col- "kat.nvim")
        (and (> timeLocal 8)
             (<= timeLocal 12))
        (col- "kat.lightenwim")
        (and (> timeLocal 12)
             (<= timeLocal 15))
        (col- "kat.lightenvim")
        (and (> timeLocal 15)
             (<= timeLocal 20))
        (col- "kat.nwim")
        (col- "kat.nvim"))))
