module Test.Main where

import Prelude

import Data.List (List)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Random (RANDOM)
import Control.Monad.Eff.Exception (EXCEPTION)
import Type.Proxy (Proxy(..), Proxy2(..))
import Test.QuickCheck.Laws.Control.Comonad (checkComonad)
import Test.QuickCheck.Laws.Control.Applicative (checkApplicative)
import Test.QuickCheck.Laws.Control.Extend (checkExtend)
import Test.QuickCheck.Laws.Data.Monoid (checkMonoid)
import Test.QuickCheck.Laws.Data.Ord (checkOrd)

import Data.Pair (Pair)

proxy2 :: Proxy2 Pair
proxy2 = Proxy2

proxyI :: Proxy (Pair Number)
proxyI = Proxy 

proxyM :: Proxy (Pair (List Number))
proxyM = Proxy

main :: forall eff. Eff ( console :: CONSOLE , random :: RANDOM
        , err :: EXCEPTION
        | eff) Unit
main = do
    checkOrd proxyI
    checkMonoid proxyM
    checkExtend proxy2
    checkApplicative proxy2
    checkComonad proxy2
