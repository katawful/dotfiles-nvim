(comment) @comment
(float) @float
(integer) @number
(plain_string) @string
(string) @string
(function) @function.builtin
(reference) @symbol
(unimplemented) @text.underline

[
  "["
  "]"
  "{"
  "}"
  "("
  ")"]
@punctuation.bracket

[
  "."
  ","]
@punctuation

[
  (string_type)
  (number_type)
  (float_type)
  (array_type)
  (ref_type)]
@type

script_name: (reference) @define
user_defined_function: (reference) @function
(user_defined_function) @function
((parameter) @parameter
            (#set! "priority" 1000))

variable: (reference) @variable
(method
  (reference) @variable
  "." @method.call
  (function) @method)

field: (reference) @field

[
  "scn"
  "scriptname"
  "begin"
  "end"]
@keyword

"call" @function.call
"return" @keyword.return

[
  "goto"
  "saveip"
  "restoreip"
  "label"]
@label

[
  "if"
  "elseif"
  "else"
  "endif"]
@conditional

[
  "while"
  "loop"
  "break"
  "continue"
  "foreach"]
@repeat

[
  "let"
  "set"
  "to"]
@keyword

[
  "||"
  "&&"
  "=="
  "!="
  ">"
  ">="
  "<"
  "<="
  "|"
  "&"
  "<<"
  ">>"
  "+"
  "-"
  "*"
  "/"
  "%"
  "^"
  ":="
  "+="
  "-="
  "*="
  "/="
  "^="
  ":="
  "-"
  "$"
  "#"
  "*"
  "&"
  "!"
  "->"
  "<-"]
@operator

"|" @string.special
(format_specifier) @string.escape
(internal_string) @string

(game_feature) @namespace
quest: (reference) @namespace

(ERROR) @error
