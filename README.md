<!-- idris
module README

import Data.SortedSet

import Syntax.IHateParens
import Syntax.Monad.Logic
-->

# I hate parenthesis

Syntax utilities for those who does too, for Idris 2

## Functions

I often find myself in calling a several-argument functions with non-trivial expressions,
which do not worth putting to a separate variable. So, I need to do something like this:

<!-- idris
f : Nat -> Nat -> Nat

namespace Pre {
-->

```idris
val : Nat -> Nat
val a = f (a + 5) (a `minus` 4)
```

<!-- idris
 }
-->

which contains disgusting parenthesis.

We can't use `$`-operator, because it is right-associative.
So, let's use this library and its left-associative operator `.|`:

```idris
val : Nat -> Nat
val a = f .| a + 5 .| a `minus` 4
```

No parens!

## Collections

Sometimes we have logic on a property of a collection.
Those properties are usually functions and usually they require parenthesis, brrr...
Sometimes we can get rid of them, and make things look a bit more readable (if you get used to new functions).

```idris
aVect : (set : SortedSet String) -> Vect set.size String
aVect set = set.asVect
```

## Monad logic

Monads parameterised by `Bool` form a short-circuiting logic, e.g.

```idris
d : Monad m => m Bool -> m Bool -> m String
d cond1 cond2 =
  if !(cond1 && cond2)
    then pure "no"
    else pure "yes"
```
