(module core {require-macros [katcros-fnl.macros.nvim.api.options.macros]})

;; System
(set-opts {mouse :nvi
           number true
           relativenumber true
           modeline true
           undofile true
           hidden false
           updatetime 100
           cmdheight 2
           title true})

(set-opt clipboard :unnamedplus :append)

;; Fold
(set-opts {foldenable false
           foldmethod :syntax
           foldtext "substitute(getline(v:foldstart),'\t',repeat(' ',&tabstop),'g').'  '.trim(getline(v:foldend))"
           foldcolumn :3})

;; List
(set-opt list true)
(set-opt listchars {:tab "  " :trail "■" :extends ">" :precedes "<"})

;; Tab
(set-opts {tabstop 2 shiftwidth 2 expandtab true})

;; Conceal
(set-opt conceallevel 2)

;; Break
(set-opts {breakindent true linebreak true showbreak "=>"})

(set-opt inccommand :nosplit)

(set-opt nrformats :octal :remove)

(vim.diagnostic.config {:virtual_text false})

(set-opt guifont "FiraCode Nerd Font Mono:h11,MesloLGS NF:h11,DejavuSans:h11")
; (set- guifont "MesloLGS NF:h11")
; (set- guifont "FiraCode Nerd Font:h11")
(if (= vim.g.neovide true)
    (do
      (set-vars g {:neovide_cursor_animation_length 0.02
                   :neovide_cursor_trail_length 2
                   :neovide_cursor_vfx_mode :railgun
                   :neovide_cursor_vfx_opacity 100
                   :neovide_cursor_vfx_particle_density 20
                   :neovide_cursor_vfx_particle_speed 10
                   :neovide_remember_window_size false
                   :neovide_remember_window_position false})))

(match sys.name
  "Kat-Arch" (set-var g :neovide_transparency 0.9))
