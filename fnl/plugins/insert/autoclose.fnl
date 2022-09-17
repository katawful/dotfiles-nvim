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
         ;; if current character is the bracket then return <Right>
           (do
             ; we need to use the termcode directly, else <Right> prints literally
             (set result :<Right>))
           (do
             (set result (tostring bracket)))) result)

(defn- opener-closer [bracket]
  "Open and close a bracket"
  (let [cursor (vim.api.nvim_win_get_cursor 0)
        position {:row "" :col ""}
        line (vim.api.nvim_get_current_line)
        result [""]]
   (each [k v (pairs cursor)]
     (match k 1 (set position.row (+ 1 v)) 2 (set position.col (+ 1 v))))
   (let [char (line:sub position.col position.col)]
      (if (= bracket char)
        (do (tset result 1 :<Right>))
        (do (tset result 1 (.. bracket bracket "<Left>"))))
      (. result 1))))

;;; Public
;; FN -- self named, called for the ending bracket needed
(defn parenthesis [] (closer ")"))

(defn bracket [] (closer "]"))

(defn brace [] (closer "}"))

(defn bar [] (opener-closer "|"))
