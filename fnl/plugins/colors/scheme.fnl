(module plugins.colors.scheme
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.colors.macros]})

(defn change-kitty [back color] "Change out kitty scheme"
      (let [name (string.format "Kitty-%s-%s" color back)]
        (vim.fn.system (string.format "kitty +kitten themes --reload-in=all %s"
                                      name))))

(defn set* [] (let [timeLocal (tonumber (vim.fn.strftime "%H"))
                    background vim.o.background
                    color vim.g.colors_name]
                (if (and (>= timeLocal 18) (< timeLocal 8))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nvim)
                          (change-kitty :dark :kat.nvim))))
                    (and (>= timeLocal 8) (< timeLocal 11))
                    (do
                      (when (or (not= background :light) (not= color :kat.nwim))
                        (do
                          (set vim.o.background :light)
                          (col- :kat.nwim)
                          (change-kitty :light :kat.nwim))))
                    (and (>= timeLocal 11) (< timeLocal 15))
                    (do
                      (when (or (not= background :light) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :light)
                          (col- :kat.nvim)
                          (change-kitty :light :kat.nvim))))
                    (and (>= timeLocal 15) (< timeLocal 18))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nwim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nwim)
                          (change-kitty :dark :kat.nwim))))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nvim)
                          (change-kitty :dark :kat.nvim)))))))
