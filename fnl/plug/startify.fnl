(module startify
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.utils.macros
                         katcros-fnl.macros.nvim.api.maps.macros
                         katcros-fnl.macros.nvim.api.autocommands.macros]})

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

(defn- padding-size []
  (let [width (vim.api.nvim_win_get_width 0)
        padding (if (> width 100)
                  (math.floor (/ (- width 80) 2))
                  4)]
    padding))
(def- padding {:last 0})

(defn- whitespace-size [amount]
  (var output "")
  (for [i 0 (- amount 9)]
    (set output (string.format "%s " output)))
  output)

; (set vim.g.ascii
;   [
;     "             /( ,,,,, )\\ "
;     "            _\\,;;;;;;;,/_ "
;     "         .-'; ;;;;;;;;; ;'-. "
;     "         '.__/`_ / \\ _`\\__.' "
;     "            | (')| |(') | "
;     "            | .--' '--. | "
;     "            |/ o     o \\| "
;     "            |           | "
;     "           / \\ _..=.._ / \\ "
;     "          /:. '._____.'   \\ "
;     "         ;::'    / \\      .; "
;     "         |     _|_ _|_   ::| "
;     "       .-|     '==o=='    '|-. "
;     "      /  |  . /       \\    |  \\ "
;     "      |  | ::|         |   | .| "
;     "      |  (  ')         (.  )::| "
;     "      |: |   |; U U U ;|:: | `| "
;     "      |' |   | \\ U U / |'  |  | "
;     "      ##V|   |_/`\"\"\"`\\_|   |V## "
;     "         ##V##         ##V## "])
(set vim.g.ascii
     [

      "                      ░░                    ░░                           "
      "                      ░░                    ░░                           "
      "                    ░░░░                    ░░░░                         "
      "                  ▒▒▒▒▒▒░░                ░░▒▒▒▒▒▒                       "
      "                      ▒▒░░                ░░▒▒                           "
      "                        ████████████░░░░░░░░                            "
      "    ░░░░░░            ▓▓▓▓▓▓▓▓▓▓            ░░            ░░░░░░         "
      "  ░░      ░░      ████▓▓▓▓▓▓▓▓▓▓              ░░░░      ░░      ░░       "
      "    ░░    ░░░░  ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓                  ░░  ░░░░░░  ░░         "
      "    ░░░░░░░░░░██▓▓▓▓▓▓▓▓▓▓▓▓▓▓                      ░░░░░░░░░░░░    ██   "
      "      ░░░░░░  ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓                      ░░  ░░░░░░██████▓▓██ "
      "              ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓                      ░░      ▓▓▓▓▓▓▓▓▓▓██ "
      "            ░░▓▓▓▓▓▓▓▓▓▓██▓▓              ██          ░░  ██▓▓▓▓▓▓▓▓▓▓██ "
      "            ░░  ▓▓▓▓▓▓██▓▓██            ██  ██        ░░  ██▓▓▓▓▓▓████   "
      "            ░░    ▓▓▓▓▓▓░░                            ░░  ██▓▓▓▓▓▓       "
      "            ░░                ▒▒▒▒▒▒▒▒                ░░  ██▓▓██         "
      "            ░░░░      ░░  ░░▒▒░░░░░░░░▒▒▒▒          ░░      ▒▒░░░░       "
      "            ░░  ▒▒░░░░  ▒▒░░░░░░░░░░░░░░░░▒▒    ░░░░        ░░  ░░       "
      "                    ░░▒▒░░░░▒▒░░░░░░░░▒▒░░░░▒▒░░            ░░  ░░       "
      "                  ██▓▓▓▓▒▒░░░░░░░░░░░░░░░░▒▒░░░░░░        ░░  ░░         "
      "                ██▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░▒▒░░░░    ░░    ░░  ░░           "
      "                ██▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░      ░░  ░░  ░░             "
      "              ░░    ▓▓▓▓  ░░░░░░░░░░░░░░░░          ░░  ░░               "
      "              ░░                                  ▓▓▓▓░░                 "
      "              ░░            ░░░░░░░░░░░░        ██▓▓██                   "
      "              ░░      ░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓██                   "
      "              ░░    ░░░░░░░░  ░░░░░░░░  ░░░░░░▓▓▓▓████                   "
      "              ░░    ░░░░░░░░            ░░░░░░▓▓██████                   "
      "                ░░░░░░░░░░                ░░░░░░░░▒▒                     "
      "                ▓▓▒▒▒▒▒▒▒▒██            ▓▓▒▒▒▒▒▒▒▒▓▓                     "
      "                ▓▓▒▒▓▓▒▒▓▓▓▓            ▓▓▒▒▓▓▒▒▓▓▓▓                     "
      "                ░░▓▓▓▓▓▓▓▓                ▒▒▓▓▓▓▓▓░░ "])


(defn- update-variables []
  (set padding.last (padding-size))
  (let- g :startify_lists
      [{:type :commands
        :header [(.. (whitespace-size (padding-size)) "Commands")]}
       {:type :files
        :header [(.. (whitespace-size (padding-size)) "Recent Global Files")]}
       {:type :dir
        :header [(.. (whitespace-size (padding-size))  "Recent Files in: " (vim.fn.getcwd))]}
       {:type startShowCurrRepo
        :header [(.. (whitespace-size (padding-size)) "Commits in: " (vim.fn.getcwd))]}
       {:type :sessions
        :header [(.. (whitespace-size (padding-size)) "Sessions")]}
       {:type :bookmarks
        :header [(.. (whitespace-size (padding-size)) "Bookmarks")]}])
  (let- g :startify_padding_left (padding-size))
  (let- g :startify_files_number 5)
  (let- g :startify_bookmarks 
      [{:i "~/fnl/init.fnl"}
       {:z "~/.zshrc"}
       {:c "~/.config/i3/config"}])
  (let- g :startify_fortune_use_unicode 1)

  (let- g :startify_commands
      [{:d [" Open directory" :KatFZFGetListDirs]}
       {:s [" Search for directory" :KatFZFSearchDir]}
       {:f [" Search for file" :KatFZFOpenFile]}
       {:b [" Search for buffer" :KatFZFOpenBuffer]}
       {:m [" Search for marks" :KatFZFOpenMarks]}
       {:h [" Search help tags" :KatFZFOpenHelpTags]}])
  (let- g :startify_custom_header ((. vim.fn :startify#center) vim.g.ascii)))
(update-variables)

(defn- kat-start-delay [time#]
  (if (= vim.b.current_syntax :startify)
    (do
      (if (or (> padding.last 0)
              (not= padding.last (padding-size)))
        (let [timer (vim.loop.new_timer)]
          (timer:start time# 0
                       (vim.schedule_wrap
                         (fn []
                          (if (= vim.b.current_syntax :startify)
                            (do
                              (update-variables)
                              ((. vim.fn "startify#insane_in_the_membrane") 0 1)))))))))))

(defn- kat-start [split]
  (match split
    :none (do
            (update-variables)
            ((. vim.fn "startify#insane_in_the_membrane") 0 1))
    :hor (do
           (vim.cmd "split")
           (update-variables)
           ((. vim.fn "startify#insane_in_the_membrane") 0 1))
    :ver (do
           (vim.cmd "vsplit")
           (update-variables)
           ((. vim.fn "startify#insane_in_the_membrane") 0 1))
    :tab (do
           (vim.cmd "tabnew")
           (update-variables)
           ((. vim.fn "startify#insane_in_the_membrane") 0 1))))


(command- :KatStart (fn [] (update-variables)
                      ((. vim.fn "startify#insane_in_the_membrane") 0 1))
          "Open a Startify window with fresh vars")

(let [startify (def-aug- "startifyResize")]
  (aug- startify
    (auc- [:VimResized
           :WinEnter]
          "*"
          (fn [] (kat-start-delay 1))
          "Update startify on window changes")))
    ; (auc- :WinScrolled
    ;       "*"
    ;       (fn [] (kat-start-delay 250))
    ;       "Update startify on window changes")))

(nno- :<leader>sn (fn [] (kat-start :none)) "Open Startify in window")
(nno- :<leader>ss (fn [] (kat-start :hor)) "Open Startify in split")
(nno- :<leader>sv (fn [] (kat-start :ver)) "Open Startify in vsplit")
(nno- :<leader>st (fn [] (kat-start :tab)) "Open Startify in tab")
