(module kat
        {require-macros [macros]})

(let- g :kat_fg {1 "#daf6ff"
                 2 "#b5d5df"
                 3 "#8dbcca"
                 4 "#699faf"
                 5 "#4f7e8c"
                 6 "#325049"})
(let- g :kat_bg {1 "#121c2d"
                 2 "#1c2e4a"
                 3 "#2c466e"
                 4 "#46689c"
                 5 "#6690d0"
                 6 "#78adff"})
; order: normal, contragt, dull
(let- g :kat_red {1 "#eb4949"
                  2 "#ff5a5a" 
                  3 "#9c3636"})
(let- g :kat_green {1 "#8ceba9"
                    2 "#9dffd2"
                    3 "#60b77a"})
(let- g :kat_orange {1 "#f2b15c"
                     2 "#ffe861"
                     3 "#ce8b33"})
(let- g :kat_pink {1 "#f29cb1"
                   2 "#ffaed5"
                   3 "#a73953"})
(let- g :kat_purple {1 "#c8a5f1"
                     2 "#f9b5ff"
                     3 "#7a53a8"})
(let- g :kat_blue {1 "#7bb7c9"
                   2 "#8af9ff"
                   3 "#388ba4"})

(local kat {})

(set kat.normal {:a {:bg (. vim.g.kat_purple 1) 
                     :fg (. vim.g.kat_bg 1) 
                     :gui :bold}
                 :b {:bg (. vim.g.kat_bg 6) 
                     :fg (. vim.g.kat_bg 1)}
                 :c {:bg (. vim.g.kat_pink 2) 
                     :fg (. vim.g.kat_bg 1)}})

(set kat.insert {:a {:bg (. vim.g.kat_blue 1) 
                     :fg (. vim.g.kat_bg 1) 
                     :gui :bold}
                 :b {:bg (. vim.g.kat_bg 6) 
                     :fg (. vim.g.kat_bg 1)}
                 :c {:bg (. vim.g.kat_blue 2) 
                     :fg (. vim.g.kat_bg 1)}})

(set kat.visual {:a {:bg (. vim.g.kat_red 1) 
                     :fg (. vim.g.kat_bg 1) 
                     :gui :bold}
                 :b {:bg (. vim.g.kat_bg 5) 
                     :fg (. vim.g.kat_bg 1)}
                 :c {:bg (. vim.g.kat_purple 1) 
                     :fg (. vim.g.kat_bg 1)}})

(set kat.replace {:a {:bg (. vim.g.kat_orange 1) 
                      :fg (. vim.g.kat_bg 1) 
                      :gui :bold}
                  :b {:bg (. vim.g.kat_bg 6) 
                      :fg (. vim.g.kat_bg 1)}
                  :c {:bg (. vim.g.kat_blue 2) 
                      :fg (. vim.g.kat_bg 1)}})

(set kat.command {:a {:bg (. vim.g.kat_green 1) 
                      :fg (. vim.g.kat_bg 1) 
                      :gui :bold}
                  :b {:bg (. vim.g.kat_bg 6) 
                      :fg (. vim.g.kat_bg 1)}
                  :c {:bg (. vim.g.kat_green 3) 
                      :fg (. vim.g.kat_bg 1)}})

(set kat.terminal {:a {:bg (. vim.g.kat_pink 3) 
                      :fg (. vim.g.kat_bg 1) 
                      :gui :bold}
                  :b {:bg (. vim.g.kat_bg 6) 
                      :fg (. vim.g.kat_bg 1)}
                  :c {:bg (. vim.g.kat_red 3) 
                      :fg (. vim.g.kat_bg 1)}})

(set kat.inactive {:a {:bg (. vim.g.kat_fg 3)
                      :fg (. vim.g.kat_bg 1)}
                  :b {:bg (. vim.g.kat_bg 6)
                      :fg (. vim.g.kat_bg 1)}
                  :c {:bg (. vim.g.kat_fg 3)
                      :fg (. vim.g.kat_bg 1)}})
kat
