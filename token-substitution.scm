(module
 token-substitution
 (substitute-tokens
  substitute-tokens/partial)

 (import scheme
         chicken
         data-structures)

 (use srfi-1
      vector-lib
      debug)

 (include "substitute-tokens.scm"))
