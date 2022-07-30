(module plugins.colors.scheme
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.colors.macros]})

(defn set* [] (let [timeLocal (tonumber (vim.fn.strftime "%H"))
                    background vim.o.background
                    color vim.g.colors_name]
                (set-var g kat_nvim_integrations
                         [:lsp
                          :treesitter
                          :ts_rainbow
                          :indent_blankline
                          :startify
                          :coc
                          :cmp
                          :fugitive])
                (if (and (> timeLocal 18) (<= timeLocal 8))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nvim))))
                    (and (> timeLocal 8) (<= timeLocal 11))
                    (do
                      (when (or (not= background :light) (not= color :kat.nwim))
                        (do
                          (set vim.o.background :light)
                          (col- :kat.nwim))))
                    (and (> timeLocal 11) (<= timeLocal 15))
                    (do
                      (when (or (not= background :light) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :light)
                          (col- :kat.nvim))))
                    (and (> timeLocal 15) (<= timeLocal 18))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nwim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nwim))))
                    (do
                      (when (or (not= background :dark) (not= color :kat.nvim))
                        (do
                          (set vim.o.background :dark)
                          (col- :kat.nvim)))))))
