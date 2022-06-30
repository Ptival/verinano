module Main


import Data.Fin

import Container


data If2 = Condition | ThenExpression


if2C : Container
if2C = MkContainer If2 pos
  where
    pos : If2 -> Type
    pos Condition = ()
    pos ThenExpression = ()


if2 : Type
if2 = W if2C


namespace Src

  public export
  data Src
    = If2 Src Src
    | If3 Src Src Src


namespace Tgt

  public export
  data Tgt
    = If3 Tgt Tgt Tgt
    | Void


removeOneArmedIf : Src.Src -> Tgt.Tgt
removeOneArmedIf (Src.If2 c t) = Tgt.If3 (removeOneArmedIf c) (removeOneArmedIf t) Tgt.Void
removeOneArmedIf (Src.If3 c t e) = Tgt.If3 (removeOneArmedIf c) (removeOneArmedIf t) (removeOneArmedIf e)
