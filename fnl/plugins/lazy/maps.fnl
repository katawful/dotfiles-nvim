(module plugins.lazy.maps
        {autoload {s aniseed.string}
         require-macros [katcros-fnl.macros.nvim.api.maps.macros]})

;;; Module: Lazy.nvim maps

;;; Module: Lazy.nvim
;; Non-Aniseed modules seem to fail when loaded through Aniseed
(def- lazy (require :lazy))

;;; Seq: A seq of all lazy functions so I don't have to write them all
(def- lazy-functions
      [
       :build
       :check
       :clean
       :clear
       :debug
       :health
       :help
       :home
       :install
       :load
       :log
       :profile
       :restore
       :sync
       :update])

;;; String: Lazy.nvim leader header
(def lazy-leader "<leader>l")

;;; FN: Maps a key to a normal mode map with the lazy leader header
;;; @key: String -- key to map
;;; @rhs: The thing to map to
;;; @func: String -- The lazy function used
(defn- map [key rhs func] "Maps a key to a normal mode map wit the lazy leader header
@key: String -- key to map
@rhs: The thing to map to
@func: String -- The lazy function used"
  (let [description (string.format "Run :Lazy %s" func)]
    (nno- (.. lazy-leader key) rhs
          {:nowait true
           :desc (string.format "Run :Lazy %s" func)
           :silent true})))

(fn _G.lazy_command_completion [_ cmd-line _] "Completion for input"
      (let [output []
            plugins (let [out# []]
                        (each [_ v (ipairs (lazy.plugins))]
                          (table.insert out# v.name))
                        out#)]
        ;; If the cmdline is occupied we wanna narrow the search
        (if (string.match (cmd-line:sub 1 1) "%w")
            ;; Add matching completions to output
            (let [completion (cmd-line:sub 1 -1)]
              (each [_ plugin (ipairs plugins)]
                (if (string.match plugin (.. "^" completion))
                    (table.insert output plugin))))
            ;; Else output all completions available
            (do
              (each [_ plugin (ipairs plugins)]
                (table.insert output plugin))))
        output))
 
;;; FN: Ask for input and return it
;;; @prompt: String -- User prompt
(defn- input? [prompt] "Ask for input and return it)
@prompt: String -- User prompt"
       (var output "")
       (let [plugins (do (let [out# []]
                           (each [_ v (ipairs (lazy.plugins))]
                             (table.insert out# v.name))
                           out#))]
         (vim.ui.input {:prompt prompt
                        :completion "customlist,v:lua.lazy_command_completion"}
                       (fn [in] (set output in)))
         (if output
           {:plugins [output]}
           nil)))

;;; FN: Ask for select and return it
;;; @prompt: String -- User prompt
(defn- select? [items prompt] "Ask for selection and return it)
@prompt: String -- User prompt"
       (var output "")
       (let [string-items (do (let [out []]
                                (each [_ v (ipairs items)]
                                  (table.insert out v.name))
                                out))]
         (vim.ui.select string-items {:prompt prompt}
                       (fn [in] (set output in)))
         {:plugins output}))

;;; FN: Run through all Lazy functions and map them to a neat mapping
(defn all [] "Run through all Lazy functions and map them to a neat mapping"
          (map :b (fn [] (let [result (input? "Select a plugin to build: ")]
                           (if result
                             (lazy.build result)
                             (vim.notify "No result given" vim.log.levels.INFO))))
               :build)
          (map :c (fn [] (lazy.check)) :check)
          (map :D (fn [] (lazy.debug)) :debug)
          (map :H (fn [] (lazy.health)) :health)
          (map :? (fn [] (lazy.help)) :help)
          (map :h (fn [] (lazy.home)) :home)
          (map :l (fn [] (lazy.log)) :log)
          (map :P (fn [] (lazy.profile)) :profile)
          (map :s (fn [] (lazy.sync)) :sync)
          (map :u (fn [] (lazy.update)) :update))

(all)
