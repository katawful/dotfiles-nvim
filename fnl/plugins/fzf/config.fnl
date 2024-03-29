(module plugins.fzf.config
        {autoload {fzf fzf
                   fzf-lua fzf-lua.init
                   preview plugins.fzf.git.preview
                   git plugins.fzf.git.init
                   repos plugins.git.repos}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.utils.macros]})

;;; FZF plugin configuration

(def- actions (require :fzf-lua.actions))

;; Setup -- setup table for fzf.lua
;; https://github.com/ibhagwan/fzf-lua
(opt- :fzf-lua :setup
      {:winopts {:border [" " " " " " " " " " " " " " " "]
                 :hl {:normal :MsgArea
                      :border :ModeMsg
                      :cursor :Visual
                      :cursorline :Visual
                      :title :Title
                      :scrollbar_f :PmenuThumb
                      :scrollbar_e :PmenuSbar}
                 :preview {:scrollbar :float}}
       :fzf_colors {:prompt {1 :fg 2 :Title}
                    :hl+ {1 :bg 2 :Error}
                    :hl {1 :bg 2 :WarningMsg}
                    :pointer {1 :bg 2 :Visual}
                    :fg+ {1 :fg 2 :Normal}
                    :bg+ {1 :bg 2 :Visual}
                    :fg {1 :bg 2 :Visual}}
       :files {:actions {:ctrl-x actions.file_split
                         :ctrl-y actions.file_sel_to_qf}}
       :grep {:actions {:ctrl-x actions.file_split
                        :ctrl-y actions.file_edit_or_qf}}
       :buffers {:actions {:ctrl-x actions.buf_split :ctrl-d actions.buf_del}}})

;; String -- fzf executable path
;; For some reason the fzf path is just broken on my laptop
;; Search for it and and use it directly
(defonce fzf-path (. (vim.api.nvim_get_runtime_file :bin/fzf true) 1))

;; Key -- options for nvim-fzf plugin
(defonce fzf-nvim-opts {:border :rounded})

;; Setup -- register fzf-lua for vim.ui.select
(opt- :fzf-lua :register_ui_select)

;; Call maps and user commands
(require :plugins.fzf.commands)
(require :plugins.fzf.maps)
