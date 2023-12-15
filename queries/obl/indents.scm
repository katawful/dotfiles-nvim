[
  (script_declaration)
  (variable_declaration)
  (block)
  "end"
] @indent.ignore
(statement) @indent.begin
[
  "loop"
  "else"
  "elseif"
  "endif"
] @indent.branch

(comment) @indent.ignore

(block (statement)) @indent.begin
