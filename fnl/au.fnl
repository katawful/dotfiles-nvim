(module au ; autocommands
        {require-macros [macros]})

(aug- highlightOnYank
  (auc- TextYankPost * "silent! lua vim.highlight.on_yank()"))

; terminal settings
(aug- terminalSettings
  (auc- TermOpen * "setlocal nonumber")
  (auc- TermOpen * "setlocal relativenumber!")
  (auc- TermOpen * "setlocal nospell")
  (auc- TermOpen * "setlocal bufhidden=hide"))
