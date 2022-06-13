(module fzf_con
  {autoload {fzf fzf}
   require-macros [katcros-fnl.macros.nvim.api.maps.macros
                   katcros-fnl.macros.lispism.macros
                   katcros-fnl.macros.nvim.api.utils.macros]})

; (nno- :<leader>b ":Buffers<CR>" :silent)
; (nno- "<leader>'" ":Marks<CR>" :silent)
; (nno- :<leader>f ":Files<CR>" :silent)
; (nno- :<leader>g ":Rg<CR>" :silent)

(local actions (require "fzf-lua.actions"))
(opt- :fzf-lua :setup
      {:winopts {
                 :border :rounded
                 :hl {:normal :MsgArea
                      :border :MsgArea
                      :cursor :Visual
                      :cursorline :Visual
                      :title :Title
                      :scrollbar_f :PmenuThumb
                      :scrollbar_e :PmenuSbar}}
       :fzf_colors {
                    :prompt {1 :fg 2 :Title}
                    :hl+ {1 :bg 2 :Error}
                    :hl {1 :bg 2 :WarningMsg}
                    :pointer {1 :bg 2 :Visual}
                    :fg+ {1 :fg 2 :Normal}
                    :bg+ {1 :bg 2 :Visual}
                    :fg {1 :bg 2 :Visual}}
       :files {:actions {
                         "ctrl-x" actions.file_split
                         "ctrl-y" (fn [selected]
                                    (print (. selected 1)))}}
       :buffers {:actions {
                           "ctrl-x" actions.buf_split
                           "ctrl-d" actions.buf_del}}})

; (def- working-dirs ["~/Programs_and_Stuff/Git_Repos/"
;                     "~/.config/nvim"
;                     "~/Documents/neorg/"])

;; FN -- get proper dirs based on machine i use
(defn- working-dirs []
  "Get working directories for proper machine"
  (let [uname (vim.fn.system "uname -n")]
    (if (= uname "Kat-Arch\n")
      ["~/Programs_and_Stuff/Git_Repos/"
       "~/.config/nvim"
       "~/Documents/neorg/"]
      ["~/Git Repos/"
       "~/.config/nvim"
       "~/Documents/neorg/"])))

;;; for some reason the fzf path is just broken on my laptop
;;; Search for it and and use it directly
(defonce- fzf-path (. (vim.api.nvim_get_runtime_file "bin/fzf" true) 1))
;; FN -- get a predefined list of directories
(defn- get-list-dirs []
  ((coroutine.wrap
     (fn []
       (let [result (fzf.fzf (working-dirs) "--nth=1" 
                                  {:height (+ 3 (length (working-dirs)))
                                   :width 40
                                   :fzf_binary fzf-path})]
         ; (print (fzf.fzf (working-dirs) "--nth=1" 
         ;                 {:height (+ 3 (length (working-dirs)))
         ;                  :width 40}))
         ; (print result))))))
         (when result
           (do
             (vim.fn.chdir (. result 1))
             (vim.notify (.. "cwd: " (. result 1)) vim.log.levels.INFO))))))))
; (get-list-dirs)
(command- :KatFZFGetListDirs (fn [] (get-list-dirs)) "Get a list of dirs to cd into")

;; FN -- search for directory
;; -- TODO: show preview of directory in second window
(defn- search-dirs []
  ((coroutine.wrap
     (fn []
       (let [fd (vim.loop.fs_opendir "." nil 500)
             directories []]
         (each [_ file (pairs (vim.loop.fs_readdir fd))]
           (if (= file.type :directory)
             (table.insert directories file.name)))
         (let [result (fzf.fzf directories "--nth=1"
                               {:height 20
                                :width 40
                                :fzf_binary fzf-path})]
           (when result
             (vim.fn.chdir (. result 1))
             (vim.notify (.. "cwd: " (. result 1)) vim.log.levels.INFO)
             (vim.loop.fs_close fd))))))))
(command- :KatFZFSearchDir (fn [] (search-dirs)) "Search for directories")

(defn files [opts]
  ((. (require :fzf-lua) :files) opts))
(defn buffers [opts]
  ((. (require :fzf-lua) :buffers) opts))
(defn marks [opts]
  ((. (require :fzf-lua) :marks) opts))
(defn live-grep [opts]
  ((. (require :fzf-lua) :live_grep) opts))
(defn spell-suggest [opts]
  ((. (require :fzf-lua) :spell_suggest) opts))
(defn help-tags [opts]
  ((. (require :fzf-lua) :help_tags) opts))
(command- :KatFZFOpenFile (fn [] (files)) "Open files")
(command- :KatFZFOpenBuffers (fn [] (buffers)) "Open buffers")
(command- :KatFZFOpenMarks (fn [] (marks)) "Open marks")
(command- :KatFZFOpenGrep (fn [] (live-grep)) "Open live grep")
(command- :KatFZFOpenHelpTags (fn [] (help-tags)) "Open help files")

(nno- :<leader>f (fn [] (files)) "Open FZF file window" {:silent true})
(nno- :<leader>b (fn [] (buffers)) "Open FZF buffer window" {:silent true})
(nno- "<leader>'" (fn [] (marks)) "Open FZF marks window" {:silent true})
(nno- "<leader>g" (fn [] (live-grep)) "Open FZF live grep window" {:silent true})
(nno- "z=" (fn [] (spell-suggest)) "Open FZF spell suggest window" {:silent true})
(nno- "<leader>H" (fn [] (help-tags)) "Open FZF help tags window" {:silent true})
(nno- "<leader>N" (fn [] (files {:cwd "/home/kat/Documents/neorg"})) "Open FZF window of neorg files" {:silent true})
(nno- "<leader>C" (fn [] (files {:cwd "/home/kat/.config/nvim"})) "Open FZF window of Neovim config directory" {:silent true})

; (vim.api.nvim_command "-bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)")
