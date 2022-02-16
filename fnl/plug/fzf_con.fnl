(module fzf_con
        {require-macros [macros]})

; (nno- :<leader>b ":Buffers<CR>" :silent)
; (nno- "<leader>'" ":Marks<CR>" :silent)
; (nno- :<leader>f ":Files<CR>" :silent)
; (nno- :<leader>g ":Rg<CR>" :silent)

(local actions (require "fzf-lua.actions"))
(opt- fzf-lua setup
      {:winopts {:hl {:normal :MsgArea
                      :border :MsgArea
                      :cursor :Visual
                      :cursorline :Visual
                      :title :Title
                      :scrollbar_f :PmenuThumb
                      :scrollbar_e :PmenuSbar
                      }}
       :fzf_colors {
                    :prompt {1 :fg 2 :Title}
                    :hl+ {1 :bg 2 :Error}
                    :hl {1 :bg 2 :WarningMsg}
                    :pointer {1 :bg 2 :Visual}
                    :fg+ {1 :fg 2 :Normal}
                    :bg+ {1 :bg 2 :Visual}
                    :fg {1 :bg 2 :Visual}
                    }
       :files {:actions {
                         "ctrl-x" actions.file_split
                         "ctrl-y" (fn [selected]
                                    (print (. selected 1)))
                         }}
       :buffers {:actions {
                         "ctrl-x" actions.buf_split
                         "ctrl-d" actions.buf_del
                         }}
       })

(nno- :<leader>f "<cmd>lua require('fzf-lua').files()<CR>" :silent)
(nno- :<leader>b "<cmd>lua require('fzf-lua').buffers()<CR>" :silent)
(nno- "<leader>'" "<cmd>lua require('fzf-lua').marks()<CR>" :silent)
(nno- "<leader>g" "<cmd>lua require('fzf-lua').live_grep()<CR>" :silent)
(nno- "z=" "<cmd>lua require('fzf-lua').spell_suggest()<CR>" :silent)
(nno- "<leader>H" "<cmd>lua require('fzf-lua').help_tags()<CR>" :silent)
(nno- "<leader>N" "<cmd>lua require('fzf-lua').files({cwd = \"/home/kat/Documents/neorg\"})<CR>")
(nno- "<leader>C" "<cmd>lua require('fzf-lua').files({cwd = \"/home/kat/.config/nvim\"})<CR>")

; (vim.api.nvim_command "-bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)")
