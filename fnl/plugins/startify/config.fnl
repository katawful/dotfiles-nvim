(module plugins.startify.config
        {autoload {runners plugins.startify.runners}
         require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.autocommands.macros]})

;;; Configs for vim-startify
;;; https://github.com/mhinz/vim-startify

;; FN -- gets padding size needed
(defn padding-size [] (let [width (vim.api.nvim_win_get_width 0)
                            padding (if (> width 100)
                                        (math.floor (/ (- width 80) 2))
                                        4)]
                        padding))

;; Key -- key/value table for storing the last padding
(def padding {:last 0})

;; FN -- amount of whitespace needed
;; @amount -- amount of whitespace
(defn whitespace-size [amount] (var output "")
      (for [i 0 (- amount 9)]
        (set output (string.format "%s " output))) output)

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
     ["                      ░░                    ░░                           "
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

(defn update-variables [] (set padding.last (padding-size))
      (let- g :startify_lists
            [{:type :commands
              :header [(.. (whitespace-size (padding-size)) :Commands)]}
             {:type :files
              :header [(.. (whitespace-size (padding-size))
                           "Recent Global Files")]}
             {:type :dir
              :header [(.. (whitespace-size (padding-size)) "Recent Files in: "
                           (vim.fn.getcwd))]}
             {:type startShowCurrRepo
              :header [(.. (whitespace-size (padding-size)) "Commits in: "
                           (vim.fn.getcwd))]}
             {:type :sessions
              :header [(.. (whitespace-size (padding-size)) :Sessions)]}
             {:type :bookmarks
              :header [(.. (whitespace-size (padding-size)) :Bookmarks)]}])
      (let- g :startify_padding_left (padding-size))
      (let- g :startify_files_number 5)
      (let- g :startify_bookmarks
            [{:i "~/.config/nvim/fnl/init.fnl"}
             {:z "~/.zshrc"}
             {:c "~/.config/i3/config"}])
      (let- g :startify_fortune_use_unicode 1)
      (let- g :startify_commands
            [{:s [" Search for directory" :KatFZFSearchDir]}
             {:f [" Search for file" :KatFZFOpenFile]}
             {:b [" Search for buffer" :KatFZFOpenBuffer]}
             {:m [" Search for marks" :KatFZFOpenMarks]}
             {:h [" Search help tags" :KatFZFOpenHelpTags]}
             {:d [" Search dotfile repos" :KatFZFGetDotfiles]}
             {:n [" Search Neovim repos" :KatFZFGetNeovimPlugins]}
             {:g [" Search git repos" :KatFZFGetGitRepos]}
             {:S [" Open sessions" :KatSessionSearch]}
             {:N [" Open Neorg Workspace" :KatFZFSearchNeorgWorkspaces]}])
      (let- g :startify_custom_header
            ((. vim.fn "startify#center") vim.g.ascii)))

(update-variables)

(let [startify (def-aug- :startifyResize)]
  (aug- startify (auc- [:VimResized :WinEnter :VimEnter :WinNew :WinLeave] "*"
                       (fn [args]
                         (runners.kat-start-delay 0 args.buf))
                       "Update startify on window changes")))

;; Call maps and user commands
(require :plugins.startify.maps)
(require :plugins.startify.commands)
