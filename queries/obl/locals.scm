(variable_declaration
  variable: (reference) @local.definition.var)

(reference) @local.reference
(quest_variable
  quest: (reference)
  variable: (reference) @global.reference)
parameter: (parameter) @local.reference

(block (game_feature) @local.definition.namespace)
(block
  (user_defined_function) @local.definition.function)

(let_statement
  left: (left) @local.definition.var)
(set_statement
  left: (left) @local.definition.var)
