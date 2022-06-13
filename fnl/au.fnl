(module au ; autocommands
        {require-macros [katcros-fnl.macros.nvim.api.autocommands.macros
                         katcros-fnl.macros.nvim.api.options.macros]})

; ; highlight on yank
(let [highlight (def-aug- "highlightOnYank")]
  (aug- highlight
        (auc- "TextYankPost" :* 
              (fn [] ((. (require :vim.highlight) :on_yank)))
              "Highlight yank region")))

; terminal settings
(let [terminal (def-aug- "terminalSettings")]
  (aug- terminal
   (auc- "TermOpen" :* (fn [] (setl- number false)) "No number")
   (auc- "TermOpen" :* (fn [] (setl- relativenumber false)) "No relative number")
   (auc- "TermOpen" :* (fn [] (setl- spell false)) "No spell")
   (auc- "TermOpen" :* (fn [] (setl- bufhidden :hide)) "Bufhidden")))

; apply suffixes to all files directly

(let [suffix (def-aug- "suffixAdd")]
  (fn suffix-add-run []
    (let [ext (vim.fn.expand "%:e")]
      (aug- suffix
        (auc- "FileType" ext 
              (fn []
                (setl- suffixesadd (.. "." ext)))
              "Add suffixes to all files"))))
  (aug- suffix
        (auc- "BufEnter" "*"
              suffix-add-run
              "Run suffixAdd for each buffer")))
