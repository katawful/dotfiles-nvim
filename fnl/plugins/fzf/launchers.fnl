(module plugins.fzf.launchers
        {autoload {fzf fzf
                   fzf-lua fzf-lua.init
                   config plugins.fzf.config
                   preview plugins.fzf.git.preview
                   git plugins.fzf.git.init
                   repos plugins.git.repos}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.utils.macros]})

;; FN -- get a predefined list of directories
(defn get-list-dirs []
       ((coroutine.wrap (fn []
                          (let [result (fzf.fzf (configs.working-dirs) :--nth=1
                                                {:height (+ 3
                                                            (length (configs.working-dirs)))
                                                 :width 40
                                                 :fzf_binary configs.fzf-path})]
                            (when result
                              (do
                                (vim.fn.chdir (. result 1))
                                (vim.notify (.. "cwd: " (. result 1))
                                            vim.log.levels.INFO))))))))

;; FN -- open a preview of git repos
;; @repo -- repo table to preview
(defn open-preview [repo] ; make sure we have the correct repo type in mind
      (set preview.repo-type.current repo) ; feed entries into fzf
      (fn func [fzf-cb]
        (var i 1) ; format entry so that it has an index ; item -> 1. item ; this is then what you see in fzf
        (each [_ e (ipairs (preview.contents))]
          (fzf-cb (: "%d. %s" :format i e.text))
          (set i (+ i 1)))
        (fzf-cb nil))
      (local actions
             {:default (fn [selected _]
                         (let [index (preview.get-index (. selected 1))
                               contents (. (preview.contents) index)]
                           (vim.notify (.. "cwd: " contents.dir)
                                       vim.log.levels.INFO)
                           (git.open$ contents.dir)))})
      ; :ctrl-s (fn [selected _]
      ;           (local index (preview.get-index (. selected 1)))
      ;           (print :ctrl-s (. (. (preview.contents) index) :data)))})
      ((coroutine.wrap (fn []
                         (let [selected ((. (require :fzf-lua) :fzf) {:prompt "Prompt❯ "
                                                                      :previewer preview.module-tab
                                                                      : actions
                                                                      :fzf_opts {:--delimiter "."
                                                                                 :--nth :3..}}
                                                                     func)]
                           ((. (. (require :fzf-lua) :actions) :act) actions
                                                                     selected {}))))))

;; FN -- search for directory
;; -- TODO: show preview of directory in second window
(defn search-dirs []
       ((coroutine.wrap (fn []
                          (let [fd (vim.loop.fs_opendir "." nil 500)
                                directories []]
                            (each [_ file (pairs (vim.loop.fs_readdir fd))]
                              (if (= file.type :directory)
                                  (table.insert directories file.name)))
                            (let [result (fzf.fzf directories :--nth=1
                                                  {:height 20
                                                   :width 40
                                                   :fzf_binary configs.fzf-path})]
                              (when result
                                (vim.fn.chdir (. result 1))
                                (vim.notify (.. "cwd: " (. result 1))
                                            vim.log.levels.INFO)
                                (vim.loop.fs_close fd))))))))

;; FN -- launchers built into fzf.lua
(defn files [opts] ((. (require :fzf-lua) :files) opts))

(defn buffers [opts] ((. (require :fzf-lua) :buffers) opts))

(defn marks [opts] ((. (require :fzf-lua) :marks) opts))

(defn live-grep [opts] ((. (require :fzf-lua) :live_grep) opts))

(defn spell-suggest [opts] ((. (require :fzf-lua) :spell_suggest) opts))

(defn help-tags [opts] ((. (require :fzf-lua) :help_tags) opts))
