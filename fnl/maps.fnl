(module maps
   {require-macros [macros]})

(nm- :<Space> :<Nop>)
(let- :g :mapleader " ")
(let- :g :maplocalleader ",")

; easier command line mode
(nno- ";" ":")
(nno- ":" ";")
(vno- ";" ":")
(vno- ":" ";")

; make Y behave like D and C
(nno- :Y :y$)

; HJKL to moving bindings
(nno- :H :g^)
(nno- :J "}")
(nno- :K "{")
(nno- :L :g_)
(vno- :H :g^)
(vno- :J "}")
(vno- :K "{")
(vno- :L :g_)

; quick completefunc user
(ino- :<C-u> :<C-x><C-u>)

; resize
(nno- :<C-h> :<C-W><)
(nno- :<C-j> :<C-W>+)
(nno- :<C-k> :<C-W>-)
(nno- :<C-l> :<C-W>>)

; move window
(nno- :<A-h> :<C-w>h)
(nno- :<A-j> :<C-w>j)
(nno- :<A-k> :<C-w>k)
(nno- :<A-l> :<C-w>l)

; quit terminal
(tno- :<C-Space> :<C-\><C-N>)

; show highlight
(nno- :<Leader>h ":TSHighlightCapturesUnderCursor<CR>")

; enable goyo
(nno- :<Leader>G ":Goyo<CR>")
