(module maps
   {require-macros [macros]})

(nm- :<Space> :<Nop>)
(let- :g :mapleader " ")
(let- :g :maplocalleader ",") ; i didn't like \ as local leader

; allow gf to open non-existent files
; currently not working, no idea why
; (map- :gf ":edit <cfile><CR>")

; remap C-l to return functionality
(nno- :<leader>r :<C-l>)

; easier command line mode
(nno- ";" ":")
(nno- ":" ";")
(vno- ";" ":")
(vno- ":" ";")

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

; Reselect in when adjusting indent
(vno- :< :<gv)
(vno- :> :>gv)

; maintain cursor when yanking in visual mode
(vno- :y "myy`y")
(vno- :Y "myY`y")

