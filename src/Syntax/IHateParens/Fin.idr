module Syntax.IHateParens.Fin

import public Data.Fin

%default total

public export %inline
(.asNat) : Fin n -> Nat
(.asNat) = finToNat
