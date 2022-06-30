(module au
        {autoload {format plugins.fnlfmt.format}
         require-macros [katcros-fnl.macros.nvim.api.autocommands.macros
                         katcros-fnl.macros.nvim.api.utils.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

;; AUG -- highlight yank settings
;; 1. highlight text yank
(let [highlight (def-aug- :highlightOnYank)]
  (aug- highlight (auc- :TextYankPost "*"
                        (fn []
                          ((. (require :vim.highlight) :on_yank)))
                        "Highlight yank region")))

;; AUG -- terminal
;; 1. set no number, relative number and spell. Also set buffer hidden
(let [terminal (def-aug- :terminalSettings)]
  (aug- terminal (auc- :TermOpen "*"
                       (fn []
                         (setl- number false)
                         (setl- relativenumber false)
                         (setl- spell false)
                         (setl- bufhidden :hide))
                       "No number, relativenumber, & spell. Bufhidden")))

;; AUG -- suffix addition
;; 1. add appropriate suffixes to each filetype
(let [suffix (def-aug- :suffixAdd)]
  (fn suffix-add-run []
    (let [ext (vim.fn.expand "%:e")]
      (aug- suffix (auc- :FileType ext
                         (fn []
                           (setl- suffixesadd (.. "." ext)))
                         "Add suffixes to all files"))))

  (aug- suffix (auc- :BufEnter "*" suffix-add-run
                     "Run suffixAdd for each buffer")))

;; FN -- see if we are in a config directory
(defn in-config-dir? [] "Get configuration directory"
      (let [config-root (.. vim.env.HOME :/.config/nvim)
            current-file (vim.loop.cwd)]
        (if (current-file:find config-root) true false)))

;; AUG -- config directory specific
;; 1. Config local user command for formatting config files
(let [config-group (def-aug- :configsOnly)]
  (aug- config-group
        (auc- :BufEnter "*"
              (fn []
                (if (in-config-dir?)
                    (command- :KatFormatConfigs
                              (fn []
                                (format.configs!))
                              "Config local formatting user command"
                              {:buffer true}))))))
