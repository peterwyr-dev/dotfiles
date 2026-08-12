; Generic delimiter pairs for the Scala Treesitter grammar.
((_
  "(" @delimiter
  ")" @delimiter) @container)

((_
  "[" @delimiter
  "]" @delimiter) @container)

((_
  "{" @delimiter
  "}" @delimiter) @container)
