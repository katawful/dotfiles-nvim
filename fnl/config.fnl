(module core
  {require-macros [macros]})

(set- mouse "a")
(set- number true)
(set- relativenumber true)
(set- modeline true)
(set- foldmethod "syntax")

(set- updatetime 100)
(set- cmdheight 2)
(set- list true)
(set- listchars "tab:  ,trail:■,extends:>,precedes:<")
(seta- clipboard "unnamedplus")

(setl- tabstop 2)
(setl- shiftwidth 2)
(setg- expandtab true)

(set- conceallevel 2)
(set- breakindent true)
(set- linebreak true)
(set- showbreak "=>")

(set- inccommand "nosplit")
; (col- "kat.nvim")
(set- title true)

(setr- nrformats :octal)

(defn changeColorscheme []
  (let [timeLocal (tonumber (vim.fn.strftime "%H"))]
    (if (and (> timeLocal 20)
             (<= timeLocal 8))
        (col- "kat.nvim")
        (and (> timeLocal 8)
             (<= timeLocal 12))
        (col- "kat.lightenvim-owo")
        (and (> timeLocal 12)
             (<= timeLocal 15))
        (col- "kat.lightenvim")
        (and (> timeLocal 15)
             (<= timeLocal 20))
        (col- "kat.nvim-owo")
        (col- "kat.nvim"))))
(changeColorscheme)

; (set- guifont "FiraCode Nerd Font:h15, MesloLGS NF:h15,DejavuSans:h15")
