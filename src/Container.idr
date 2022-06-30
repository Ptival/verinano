module Container


import Data.Fin

public export
record Container where
  constructor MkContainer
  shape : Type
  position : shape -> Type


export
container : Container -> Type -> Type
container (MkContainer s p) x = (v : s ** p v -> x)


export
data W : Container -> Type where
  In : container c (W c) -> W c


Semigroup Container where
  c1 <+> c2 = MkContainer S p
  where
    S : Type
    S = Either (shape c1) (shape c2)

    p : S -> Type
    p (Left l) = position c1 l
    p (Right r) = position c2 r
