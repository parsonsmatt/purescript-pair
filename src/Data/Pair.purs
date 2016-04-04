module Data.Pair where

import Prelude

import Control.Comonad (class Comonad)
import Control.Lazy (class Lazy, defer)
import Control.Extend (class Extend)
import Data.Monoid (class Monoid, mempty)
import Data.Foldable (class Foldable)
import Data.Traversable (class Traversable, sequenceDefault)
import Data.Tuple as T

data Pair a = Pair a a

class HasFst t a where
    fst :: t -> a

instance hasFstPair :: HasFst (Pair a) a where
    fst (Pair a _) = a

instance hasFstTuple :: HasFst (T.Tuple a b) a where
    fst = T.fst

class HasSnd t a where
    snd :: t -> a

instance hasSndPair :: HasSnd (Pair a) a where
    snd (Pair _ a) = a

instance hasSndTuple :: HasSnd (T.Tuple a b) b where
    snd = T.snd

first :: forall a. (a -> a) -> Pair a -> Pair a
first f (Pair a b) = Pair (f a) b

second :: forall a. (a -> a) -> Pair a -> Pair a
second f (Pair a b) = Pair a (f b)

instance showPair :: Show a => Show (Pair a) where
    show (Pair a b) = "Pair " <> show a <> " " <> show b

instance eqPair :: Eq a => Eq (Pair a) where
    eq (Pair a b) (Pair c d) = a == c && b == d

instance ordPair :: Ord a => Ord (Pair a) where
    compare (Pair a b) (Pair c d) = compare a c <> compare b d

instance boundedPair :: Bounded a => Bounded (Pair a) where
    top = Pair top top
    bottom = Pair bottom bottom

instance functorPair :: Functor Pair where
    map f (Pair a b) = Pair (f a) (f b)

instance applyPair :: Apply Pair where
    apply (Pair f g) (Pair a b) = Pair (f a) (g b)

instance applicativePair :: Applicative Pair where
    pure a = Pair a a

instance semigroupPair :: Semigroup a => Semigroup (Pair a) where
    append (Pair a b) (Pair c d) = Pair (a <> c) (b <> d)

instance monoidPair :: Monoid a => Monoid (Pair a) where
    mempty = Pair mempty mempty

instance foldablePair :: Foldable Pair where
    foldMap f (Pair a b) = f a <> f b
    foldr k z (Pair a b) = k a (k b z)
    foldl k z (Pair a b) = k (k z a) b

instance traversablePair :: Traversable Pair where
    traverse f (Pair a b) = Pair <$> f a <*> f b
    sequence = sequenceDefault

instance lazyPair :: (Lazy a) => Lazy (Pair a) where
    defer f = Pair (defer (\_ -> fst (f unit))) (defer (\_ -> snd (f unit)))

instance extendPair :: Extend Pair where
    extend f p = let n = f p in Pair n n

instance comonadPair :: Comonad Pair where
    extract (Pair a _) = a
