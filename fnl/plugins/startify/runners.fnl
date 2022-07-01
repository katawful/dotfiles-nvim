(module plugins.startify.runners
        {autoload {configs plugins.startify.config}
         require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.utils.macros
                         katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.autocommands.macros]})

(defn startShowCurrRepo [] ; make sure we are in a git repo
      (vim.cmd "silent! !git rev-parse --is-inside-work-tree")
      (when (= vim.v.shell_error 0) ; create the table of git commits
        (let [commits (vim.fn.systemlist "git log --oneline | head -n5")
              output []] ; this gets the info we need
          (local lineRegex (vim.regex "\\s\\zs.*")) ; this is so we can use fugitive on it
          (local showRegex (vim.regex "^\\x\\+"))
          (local iter 1) ; iterate over the initial table to construct things
          (each [_ v (ipairs commits)] ; create the 'line': strings
            (local index (lineRegex:match_str v))
            (local line (v:sub (+ index 1))) ; create the 'cmd': strings
            (local show (v:sub 0 (- index 1))) ; create the table
            (table.insert output {: line :cmd (.. "Git show " show)})
            (+ iter 1))
          output)))

(defn kat-start-delay [time#]
      (if (= vim.b.current_syntax :startify)
          (do
            (if (or (> configs.padding.last 0)
                    (not= configs.padding.last (configs.padding-size)))
                (let [timer (vim.loop.new_timer)]
                  (timer:start time# 0
                               (vim.schedule_wrap (fn []
                                                    (if (= vim.b.current_syntax
                                                           :startify)
                                                        (do
                                                          (configs.update-variables)
                                                          ((. vim.fn
                                                              "startify#insane_in_the_membrane") 0)))))))))))

(defn kat-start [split]
      (match split
        :none (do
                (configs.update-variables)
                ((. vim.fn "startify#insane_in_the_membrane") 0 1))
        :hor (do
               (vim.cmd :split)
               (configs.update-variables)
               ((. vim.fn "startify#insane_in_the_membrane") 0 1))
        :ver (do
               (vim.cmd :vsplit)
               (configs.update-variables)
               ((. vim.fn "startify#insane_in_the_membrane") 0 1))
        :tab (do
               (vim.cmd :tabnew)
               (configs.update-variables)
               ((. vim.fn "startify#insane_in_the_membrane") 0 1))))
