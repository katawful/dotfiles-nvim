(module startify
        {require-macros [macros]})

(defn- startShowCurrRepo []
  ; make sure we are in a git repo
  (vim.cmd "silent! !git rev-parse --is-inside-work-tree")
  (when (= vim.v.shell_error 0)
    ; create the table of git commits
    (let [commits (vim.fn.systemlist "git log --oneline | head -n5")
          output []]

      ; this gets the info we need
      (local lineRegex (vim.regex "\\s\\zs.*"))
      ; this is so we can use fugitive on it
      (local showRegex (vim.regex "^\\x\\+"))
      (local iter 1)

      ; iterate over the initial table to construct things
      (each [_ v (ipairs commits)]
        ; create the 'line': strings
        (local index (lineRegex:match_str v))
        (local line (v:sub (+ index 1)))

        ; create the 'cmd': strings
        (local show (v:sub 0 (- index 1)))

        ; create the table
        (table.insert output {:line line
                              :cmd (.. "Git show " show)})
        (+ iter 1))
      output)))

(let- g :startify_lists
  {1 {:type :files
      :header {1 "   Recent Global Files"}}
   2 {:type :dir
      :header {1 (.. "   Recent Files in: " (vim.fn.getcwd))}}
   3 {:type startShowCurrRepo
      :header {1 (.. "   Commits in: " (vim.fn.getcwd))}}
   4 {:type :sessions
      :header {1 "   Sessions"}}
   5 {:type :bookmarks
      :header {1 "   Bookmarks"}}
   6 {:type :commands
      :header {1 "   Commands"}}})

(let- g :startify_files_number 5)
(let- g :startify_bookmarks 
  {1 {:i "~/fnl/init.fnl"}
   2 {:z "~/.zshrc"}
   3 {:s "~/.config/sway/config"}
   4 {:c "~/.config/i3/config" }})
(let- g :startify_fortune_use_unicode 1)
(let- g :startify_padding_left 8)

(let- g :startify_commands
  {1 {:l "cd ~/Documents/My Notes/C++Primer"}
   2 {:o "cd ~/Documents/Programming/oblivion-git"}
   3 {:+ "cd ~/Documents/Programming/Exercises/C++/C++ Primer Exerices"}
   4 {:S "cd ~/Documents/Programming/katawful.github.io"}
   5 {:v "VimwikiIndex"}
   6 {:d "VimwikiDiaryIndex"}})
