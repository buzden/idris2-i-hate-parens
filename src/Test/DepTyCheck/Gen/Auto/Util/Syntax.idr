module Test.DepTyCheck.Gen.Auto.Util.Syntax

import public Data.SortedMap
import public Data.SortedMap.Dependent
import public Data.SortedSet
import public Data.Vect

%default total

----------------------------
--- Function composition ---
----------------------------

infixl 0 .|

-- Instead of `f (a b) $ c d` or `f (a b) (c d)` you can write `f .| a b .| c d`
public export %inline
(.|) : (a -> b) -> a -> b
(.|) = id

-----------------------------
--- Nice postfix notation ---
-----------------------------

public export %inline
(.length) : List a -> Nat
xs.length = length xs

namespace SortedMap

  public export %inline
  (.asList) : SortedMap k v -> List (k, v)
  m.asList = SortedMap.toList m

  public export %inline
  (.size) : SortedMap k v -> Nat
  m.size = m.asList.length

  public export %inline
  (.asVect) : (m : SortedMap k v) -> Vect m.size (k, v)
  s.asVect = fromList s.asList

namespace SortedSet

  public export %inline
  (.asList) : SortedSet a -> List a
  s.asList = SortedSet.toList s

  public export %inline
  (.size) : SortedSet a -> Nat
  m.size = m.asList.length

  public export %inline
  (.asVect) : (s : SortedSet a) -> Vect s.size a
  s.asVect = fromList s.asList

-----------------------------
--- Special monadic stuff ---
-----------------------------

namespace Monad

  -- Monadically lazy on the second argument
  public export
  (&&) : Monad m => m Bool -> m Bool -> m Bool
  l && r = do
    True <- l
      | False => pure False
    r

  -- Monadically lazy on the second argument
  public export
  (||) : Monad m => m Bool -> m Bool -> m Bool
  l || r = do
    False <- l
      | True => pure True
    r
