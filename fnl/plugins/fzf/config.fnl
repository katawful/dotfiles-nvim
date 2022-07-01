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
      {:winopts {:border :rounded
                 :hl {:normal :MsgArea
                      :border :MsgArea
                      :cursor :Visual
                      :cursorline :Visual
                      :title :Title
                      :scrollbar_f :PmenuThumb
                      :scrollbar_e :PmenuSbar}}
       :fzf_colors {:prompt {1 :fg 2 :Title}
                    :hl+ {1 :bg 2 :Error}
                    :hl {1 :bg 2 :WarningMsg}
                    :pointer {1 :bg 2 :Visual}
                    :fg+ {1 :fg 2 :Normal}
                    :bg+ {1 :bg 2 :Visual}
                    :fg {1 :bg 2 :Visual}}
       :files {:actions {:ctrl-x actions.file_split
                         :ctrl-y (fn [selected]
                                   (print (. selected 1)))}}
       :buffers {:actions {:ctrl-x actions.buf_split :ctrl-d actions.buf_del}}})

;; FN -- get proper dirs based on machine i use
(defn working-dirs [] "Get working directories for proper machine"
      (let [uname (vim.fn.system "uname -n")]
        (if (= uname "Kat-Arch\n")
            ["~/Programs_and_Stuff/Git_Repos/"
             "~/.config/nvim"
             "~/Documents/neorg/"]
            ["~/Git Repos/" "~/.config/nvim" "~/Documents/neorg/"])))

;; String -- fzf executable path
;; For some reason the fzf path is just broken on my laptop
;; Search for it and and use it directly
(defonce fzf-path (. (vim.api.nvim_get_runtime_file :bin/fzf true) 1))

;; Key -- options for nvim-fzf plugin
(defonce fzf-nvim-opts {:border :rounded})

;; Call maps and user commands
(require :plugins.fzf.commands)
(require :plugins.fzf.maps)
