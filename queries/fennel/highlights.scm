((symbol) @include
 (#any-of? @include
  "require" "require-macros" "import-macros" "include"
  ; aniseed
  "autoload"))

((symbol) @function.macro
 (#any-of? @function.macro
  "->" "->>" "-?>" "-?>>" "?." "doto" "macro" "macrodebug" "partial" "pick-args"
  "pick-values" "with-open"
  ; aniseed
  "defn" "def" "defn-" "def-" "defonce" "defonce-" "deftest"))
