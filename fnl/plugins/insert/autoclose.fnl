(module plugins.insert.autoclose {autoload {a aniseed.core}})

;;; Autoclosing functions

;;; Private
;; FN -- determine if we are at a bracket character and act appropriately
(defn- closer [bracket] ; get the character under the cursor
       (def getCursor (vim.api.nvim_win_get_cursor 0)) (var row 0) (var col 0)
       (var result :empty) ; this is stored as {1 r, 2 c}
       (each [k v (pairs getCursor)]
         (match k ; store column and row to vars
           1
           (set row v)
           2
           (set col v))) (def currLine (vim.api.nvim_get_current_line))
       ; get current line
       (def currCharacter (currLine:sub (+ col 1) (+ col 1)))
       ; get current character
       (if (= (tostring bracket) (tostring currCharacter))
           ; if current character is the bracket then return <Right>
           (do
             ; we need to use the termcode directly, else <Right> prints literally
             (set result :<Right>))
           (do
             (set result (tostring bracket)))) result)

;;; Public
;; FN -- self named, called for the ending bracket needed
(defn parenthesis [] (closer ")"))

(defn bracket [] (closer "]"))

(defn brace [] (closer "}"))
