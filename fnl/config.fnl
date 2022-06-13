(module core
  {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

(set- foldenable false)
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
(setl- expandtab true)

(set- conceallevel 2)
(set- breakindent true)
(set- linebreak true)
(set- showbreak "=>")

(set- inccommand "nosplit")
(set- title true)

(setr- nrformats :octal)

(vim.diagnostic.config {:virtual_text false})

(set- guifont "FiraCode Nerd Font Mono:h11,MesloLGS NF:h11,DejavuSans:h11")
; (set- guifont "MesloLGS NF:h11")
; (set- guifont "FiraCode Nerd Font:h11")
(if (= vim.g.neovide true)
  (do
    (let- :g "neovide_cursor_animation_length" 0.02)
    (let- :g "neovide_cursor_trail_length" 2)
    (let- :g "neovide_cursor_vfx_mode" :railgun)
    (let- :g "neovide_cursor_vfx_opacity" 100)
    (let- :g "neovide_cursor_vfx_particle_density" 20)
    (let- :g "neovide_cursor_vfx_particle_speed" 10)))
