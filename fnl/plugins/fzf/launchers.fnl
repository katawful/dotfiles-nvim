(module plugins.fzf.launchers
        {autoload {fzf fzf
                   fzf-lua fzf-lua.init
                   configs plugins.fzf.config
                   git-preview plugins.fzf.git.preview
                   dir-preview plugins.fzf.directory.preview
                   session-preview plugins.fzf.session.preview
                   session plugins.session.init
                   git plugins.fzf.git.init
                   repos plugins.git.repos}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.lispism.macros
                         katcros-fnl.macros.nvim.api.utils.macros]})

(defn- dirbuf-open [dir] "Open dir with dirbuf"
  ((. (require :dirbuf) :open) dir))

;; FN -- open a preview of git repos
;; @repo -- repo table to preview
(defn open-preview [repo] ; make sure we have the correct repo type in mind
      (set git-preview.repo-type.current repo) ; feed entries into fzf
      (fn func [fzf-cb]
        (var i 1)
        ;; format entry so that it has an index
        ;; item -> 1. item
        ;; this is then what you see in fzf
        (each [_ e (ipairs (git-preview.contents))]
          (fzf-cb (: "%d. %s" :format i e.text))
          (set i (+ i 1)))
        (fzf-cb nil))
      (local actions
             {:default (fn [selected _]
                         (let [index (git-preview.get-index (. selected 1))
                               contents (. (git-preview.contents) index)]
                           (vim.notify (.. "cwd: " contents.dir)
                                       vim.log.levels.INFO)
                           (git.open$ contents.dir)))})
      ((coroutine.wrap (fn []
                         (let [selected ((. (require :fzf-lua) :fzf) {:prompt "Repos❯ "
                                                                      :previewer git-preview.module-tab
                                                                      : actions
                                                                      :fzf_opts {:--delimiter "."
                                                                                 :--nth :3..}}
                                                                     func)]
                           ((. (. (require :fzf-lua) :actions) :act) actions
                                                                     selected {}))))))

(defn search-sessions []
  "Search sessions stored"
      (fn func [fzf-cb]
        (var i 1)
        ;; format entry so that it has an index
        ;; item -> 1. item
        ;; this is then what you see in fzf
        (each [_ e (ipairs (session-preview.contents))]
          (fzf-cb (: "%d. %s" :format i e.text))
          (set i (+ i 1)))
        (fzf-cb nil))
      (local actions
             {:default (fn [selected _]
                         (let [index (session-preview.get-index (. selected 1))
                               contents (. (session-preview.contents) index)]
                           (session.load! contents)))
              :ctrl-d (fn [selected _]
                         (let [index (session-preview.get-index (. selected 1))
                               contents (. (session-preview.contents) index)]
                           (session.delete! contents)))})
      ((coroutine.wrap (fn []
                         (let [selected ((. (require :fzf-lua) :fzf) {:prompt "Sessions❯ "
                                                                      :previewer session-preview.module-tab
                                                                      : actions
                                                                      :fzf_opts {:--delimiter "."
                                                                                 :--nth :3..}}
                                                                     func)]
                           ((. (. (require :fzf-lua) :actions) :act) actions
                                                                     selected {}))))))

(defn search-dirs []
  "Search directories found in cwd
Previews with dirbuf"
      (set dir-preview.contents-type.current-dir true) ; make sure we have the correct repo type in mind
      (fn func [fzf-cb] ; feed entries into fzf
        (var i 1)
        ;; format entry so that it has an index
        ;; item -> 1. item
        ;; this is then what you see in fzf
        (each [_ e (ipairs (dir-preview.contents))]
          (fzf-cb (: "%d. %s" :format i e.text))
          (set i (+ i 1)))
        (fzf-cb nil))
      (fn open-notify [dir]
        (vim.notify (.. "cwd: " dir) vim.log.levels.INFO)
        (vim.loop.chdir dir))
      (local actions
             {:default (fn [selected _]
                         "cd to directory"
                         (let [index (dir-preview.get-index (. selected 1))
                               contents (. (dir-preview.contents) index)]
                           (open-notify contents.dir)))
              :ctrl-s (fn [selected _]
                        "cd and open up fzf of new directory"
                        (let [index (dir-preview.get-index (. selected 1))
                                 contents (. (dir-preview.contents) index)]
                          (open-notify contents.dir)
                          (search-dirs)))
              :ctrl-e (fn [selected _]
                        "cd and open up fzf of new directory"
                        (let [index (dir-preview.get-index (. selected 1))
                                 contents (. (dir-preview.contents) index)]
                          (open-notify contents.dir)
                          (dirbuf-open contents.dir)))
              :ctrl-x (fn [selected _]
                        "cd and open up fzf of new directory"
                        (let [index (dir-preview.get-index (. selected 1))
                                 contents (. (dir-preview.contents) index)]
                          (open-notify contents.dir)
                          (vim.cmd "split")
                          (dirbuf-open contents.dir)))
              :ctrl-v (fn [selected _]
                        "cd and open up fzf of new directory"
                        (let [index (dir-preview.get-index (. selected 1))
                                 contents (. (dir-preview.contents) index)]
                          (open-notify contents.dir)
                          (vim.cmd "vsplit")
                          (dirbuf-open contents.dir)))})
      ((coroutine.wrap (fn []
                         (let [selected ((. (require :fzf-lua) :fzf) {:prompt "Directories❯ "
                                                                      :previewer dir-preview.module-tab
                                                                      : actions
                                                                      :fzf_opts {:--delimiter "."
                                                                                 :--nth :3..}}
                                                                     func)]
                           ((. (. (require :fzf-lua) :actions) :act) actions
                                                                     selected {}))))))

;; FN -- launchers built into fzf.lua
(defn files [opts] ((. (require :fzf-lua) :files) opts))

(defn buffers [opts] ((. (require :fzf-lua) :buffers) opts))

(defn marks [opts] ((. (require :fzf-lua) :marks) opts))

(defn live-grep [opts] ((. (require :fzf-lua) :live_grep) opts))

(defn spell-suggest [opts] ((. (require :fzf-lua) :spell_suggest) opts))

(defn help-tags [opts] ((. (require :fzf-lua) :help_tags) opts))
