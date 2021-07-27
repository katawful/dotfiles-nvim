(module closeBracket
        {require {a aniseed.core}})

(fn func [bracket]
  ; get the character under the cursor
  (def getCursor (vim.api.nvim_win_get_cursor 0))
  (var row 0)
  (var col 0)
  (var result "empty")
  ; this is stored as {1 r, 2 c}
  (each [k v (pairs getCursor)]
    (match k
      ; store column and row to vars
      1 (set row v)
      2 (set col v)))
  ; get current line
  (def currLine (vim.api.nvim_get_current_line))
  ; get current character
  (def currCharacter (currLine:sub (+ col 1) (+ col 1)))
  ; if current character is the bracket then return <Right>
  (if (= (tostring bracket) (tostring currCharacter))
    ; we need to use the termcode directly, else <Right> prints literally
    (do (set result (vim.api.nvim_replace_termcodes :<Right> true true true)))
    (do (set result (tostring bracket))))
  result)

(fn _G.paren []
  (func ")"))
(fn _G.bracket []
  (func "]"))
(fn _G.brace []
  (func "}"))

{: paren
 :bracket bracket
 :brace brace}
