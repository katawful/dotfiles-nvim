(module fzf_con
        {require-macros [macros]})

(defn doMaps []
  (nno- :<leader>b ":Buffers<CR>" :silent)
  (nno- "<leader>'" ":Marks<CR>" :silent)
  (nno- :<leader>f ":Files<CR>" :silent)
  (nno- :<leader>g ":Rg<CR>" :silent)
  )
(doMaps)

; (vim.api.nvim_command "-bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)")
