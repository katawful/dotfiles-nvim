(module tex
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.maps.macros]
         require {j plugins.jobs}})

(setl- spell true)
(set- updatetime 500)

(nno- :<leader>O ":VimtexCompileOutput<CR>" "Compile and output TeX file" {:buffer true
                                                                           :silent true})
(nno- :<leader>C ":VimtexCompile<CR>" "Compile TeX file" {:buffer true
                                                          :silent true})
(nno- :<leader>V ":VimtexView<CR>" "View current TeX file if compiled" {:buffer true
                                                                        :silent true})
(nno- :<leader>O "<Cmd>lua require('j').lazyGitUpdate()<CR>" "Update git repo" {:buffer true
                                                                                :silent true})
