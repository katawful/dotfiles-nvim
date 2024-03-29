(module tex {require-macros [katcros-fnl.macros.nvim.api.options.macros
                             katcros-fnl.macros.nvim.api.maps.macros]
             autoload {git-command plugins.git.commands}})

(set-opts-auto {spell true updatetime 500})

(nno- :<leader>O ":VimtexCompileOutput<CR>" "Compile and output TeX file"
      {:buffer true :silent true})

(nno- :<leader>C ":VimtexCompile<CR>" "Compile TeX file"
      {:buffer true :silent true})

(nno- :<leader>V ":VimtexView<CR>" "View current TeX file if compiled"
      {:buffer true :silent true})

(nno- :<leader>O (fn []
                   (git-command.lazy-update))
      "Update git repo" {:buffer true :silent true})
