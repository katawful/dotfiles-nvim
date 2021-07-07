(module au ; autocommands
        {require-macros [macros]})

(au- TextYankPost "*" "silent! lua vim.highlight.on_yank()")

; terminal settings
(au- TermOpen "*" "setlocal nonumber")
(au- TermOpen "*" "setlocal relativenumber!")
(au- TermOpen "*" "setlocal nospell")
(au- TermOpen "*" "setlocal bufhidden=hide")
