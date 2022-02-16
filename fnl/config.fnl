(module core
  {require-macros [macros]})

(set- mouse "a")
(set- number true)
(set- relativenumber true)
(set- modeline true)
(set- undofile true)
(set- hidden false)

(set- foldmethod "syntax")
(setl- foldtext "substitute(getline(v:foldstart),'\t',repeat(' ',&tabstop),'g').'  '.trim(getline(v:foldend))")
(set- foldcolumn "3")

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
(set- title true)

(setr- nrformats :octal)

(vim.diagnostic.config {:virtual_text false})

(set- guifont "FiraCode Nerd Font:h15, MesloLGS NF:h15,DejavuSans:h15")
