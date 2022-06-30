(module fennel-con
        {require-macros [katcros-fnl.macros.nvim.api.options.macros
                         katcros-fnl.macros.nvim.api.maps.macros]
         require {b plugins.closeBracket i plugins.autoIndentCurly}})

; ; enclose word
; (ino- "(" "()<Left>" :buffer)
; (ino- "[" "[]<Left>" :buffer)
; (ino- "{" "{}<Left>" :buffer)

; ; comes from plugins.closeBracket
; (ino- ")" "v:lua.paren()" :buffer :expr)
; (ino- "]" "v:lua.bracket()" :buffer :expr)
; (ino- "}" "v:lua.brace()" :buffer :expr)
; (ino- "<CR>" "v:lua.indentCurly()" :buffer :expr)

(defn vsplit [file] (vim.cmd :vsplit) (vim.cmd (.. "edit " file)))

(defn split [file] (vim.cmd :split) (vim.cmd (.. "edit " file)))

(defn edit [file] (vim.cmd (.. "edit " file)))

(defn jump->test [split-type]
      (let [dir-root (vim.fn.expand "%:h")
            file-name (vim.fn.expand "%:t:r")
            current-dir (vim.fn.getcwd)
            test-file (.. current-dir :/test/ dir-root "/" file-name :-test.fnl)]
        (match split-type
          :vsplit (vsplit test-file)
          :split (split test-file)
          :edit (edit test-file))))

; make button
(nno- :<F9> ":make!<CR>" "Run make")
(nno- :<leader>tt (fn []
                    (jump->test :edit)
                    "Jump to test"))

(nno- :<leader>tv (fn []
                    (jump->test :vsplit)
                    "Jump to test in a vsplit"))

(nno- :<leader>ts (fn []
                    (jump->test :split)
                    "Jump to test in a split"))

(setl- foldexpr "nvim_treesitter#foldexpr()")
(setl- foldmethod :expr)
