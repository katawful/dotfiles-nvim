(module maps
   {require-macros [katcros-fnl.macros.nvim.api.maps.macros
                    katcros-fnl.macros.nvim.api.options.macros]})

(nm- :<Space> :<Nop> "Set space to no operation")
(let- :g :mapleader " ")
(let- :g :maplocalleader ",") ; i didn't like \ as local leader

; allow gf to open non-existent files
; currently not working, no idea why
; (map- :gf ":edit <cfile><CR>")

(nomap- [:n :v] ";" ":" "Swap char search and command-line enter")
(nomap- [:n :v] ":" ";" "Swap command-line enter and char search")

(nomap- [:n :v] :H :g^ "Move to beginning of virtual line")
(nomap- [:n :v] :J "}" "Jump to bottom of paragraph")
(nomap- [:n :v] :K "{" "Jump to top of paragraph")
(nomap- [:n :v] :L :g_ "Move to end of virtual line")

(ino- :<C-u> :<C-x><C-u> "Enter user complete easier")

(nno- :<C-h> :<C-W>< "Shrink window horizontally")
(nno- :<C-j> :<C-W>+ "Grow window vertically")
(nno- :<C-k> :<C-W>- "Shrin window vertically")
(nno- :<C-l> :<C-W>> "Grow window horizontally")
(nno- :<leader>r "<Cmd>nohlsearch|diffupdate|normal! <C-L><CR>" "Return <C-l> functionality")

(nno- :<A-h> :<C-w>h "Go to window to the left")
(nno- :<A-j> :<C-w>j "Go to window below")
(nno- :<A-k> :<C-w>k "Go to window above")
(nno- :<A-l> :<C-w>l "Go to window to the right")

(tno- :<C-Space> :<C-\><C-N> "Easier terminal mode escape")

(vno- :< :<gv "Maintain visual mode when indenting")
(vno- :> :>gv "Maintain visual mode when indenting")

(vno- :y "myy`y" "Maintain visual mode when yanking")
(vno- :Y "myY`y" "Maintain visual mode when yanking")
