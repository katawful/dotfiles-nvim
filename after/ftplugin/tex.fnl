(module tex
        {require-macros [macros]
         require {j plugins.jobs}})

(setl- spell true)
(set- updatetime 500)

(nno- :<leader>O ":VimtexCompileOutput<CR>" :buffer :silent)
(nno- :<leader>C ":VimtexCompile<CR>" :buffer :silent)
(nno- :<leader>V ":VimtexView<CR>" :buffer :silent)
(nno- :<leader>O "<Cmd>lua require('j').lazyGitUpdate()<CR>" :buffer :silent)
