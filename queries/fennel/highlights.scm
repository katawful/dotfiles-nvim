;; extends
((symbol) @include
          (#any-of? @include
           "require" "require-macros" "import-macros" "include"))


((symbol) @function.macro
          (#any-of? @function.macro
           "->" "->>" "-?>" "-?>>" "?." "doto" "macro" "macrodebug" "partial" "pick-args"
           "pick-values" "with-open"))

((symbol) @include
          (#any-of? @include
           "autoload")
          (set! "priority" 1000))

((symbol) @function.macro
          (#any-of? @function.macro
           "defn" "def" "defn-" "def-" "defonce" "defonce-" "deftest")
          (set! "priority" 1000))

; ((list (#any-of? "defn defn-") . (symbol) (symbol) (sequential_table) (string) @string.special))
; ((list  . (symbol) (symbol) (sequential_table) (string)) @defn (#any-of? @defn "^defn ^defn-")) @string.special
; ((list . (symbol) (symbol) (sequential_table) (string) @string.special) @defn (#any-of? @defn "^defn"))
; ((list) @defn ((#any-of? @defn "defn" "def") (list) @text))
