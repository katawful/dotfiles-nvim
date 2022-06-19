((symbol) @include
    (#any-of? @include
     "require" "require-macros" "import-macros" "include"))


((symbol) @function.macro
    (#any-of? @function.macro
     "->" "->>" "-?>" "-?>>" "?." "doto" "macro" "macrodebug" "partial" "pick-args"
     "pick-values" "with-open"))

; aniseed
((symbol) @include
    (#any-of? @include
     "autoload")
    (set! "priority" 1000))

((symbol) @function.macro
    (#any-of? @function.macro
     "defn" "def" "defn-" "def-" "defonce" "defonce-" "deftest")
    (set! "priority" 1000))
