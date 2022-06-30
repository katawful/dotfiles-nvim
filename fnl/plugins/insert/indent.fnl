(module plugins.insert.indent {autoload {a aniseed.core}})

(defn curly [] ; get the character under the cursor
      (def getCursor (vim.api.nvim_win_get_cursor 0)) (var row 0) (var col 0)
      (var result :empty) ; this is stored as {1 r, 2 c}
      (each [k v (pairs getCursor)]
        (match k ; store column and row to vars
          1
          (set row v)
          2
          (set col v))) ; get current line
      (def currLine (vim.api.nvim_get_current_line)) ; get current character
      (def currCharacter (currLine:sub (+ col 1) (+ col 1)))
      (if (= "}" (tostring currCharacter)) ; print term codes
          (do
            (set result
                 :<CR><Up><End><CR>))
          (do
            (set result :<CR>)))
      result)
