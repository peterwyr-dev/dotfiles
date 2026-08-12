; Generic delimiter pairs for the C3 Treesitter grammar.
((_
  "(" @delimiter
  ")" @delimiter) @container)

((_
  "[" @delimiter
  "]" @delimiter) @container)

((_
  "{" @delimiter
  "}" @delimiter) @container)
