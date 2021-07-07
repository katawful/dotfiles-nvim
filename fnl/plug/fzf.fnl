(module fzf
        {require-macros [macros]})

(nno- :<leader>b ":Buffers<CR>")
(nno- "<leader>'" ":Marks<CR>")
(nno- :<leader>f ":Files<CR>")
(nno- :<leader>g ":Rg<CR>")

; (vim.api.nvim_command "-bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)")
