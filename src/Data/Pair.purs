module Data.Pair where

import Prelude

import Test.QuickCheck.Arbitrary (class Coarbitrary, class Arbitrary, coarbitrary, arbitrary)
import Control.Comonad (class Comonad)
import Control.Extend (class Extend)
import Control.Lazy (class Lazy, defer)
import Data.Foldable (class Foldable)
import Data.Monoid (class Monoid, mempty)
import Data.Traversable (class Traversable, sequenceDefault)
import Data.Tuple as T

-- | A pair of objects of the same type.
data Pair a = Pair a a

-- | A type class representing having a first field and extracting it.
class HasFst t a where
    fst :: t -> a

instance hasFstPair :: HasFst (Pair a) a where
    fst (Pair a _) = a

instance hasFstTuple :: HasFst (T.Tuple a b) a where
    fst = T.fst

-- | A type class representing having a second field with an extraction 
-- | operator.
class HasSnd t a where
    snd :: t -> a

instance hasSndPair :: HasSnd (Pair a) a where
    snd (Pair _ a) = a

instance hasSndTuple :: HasSnd (T.Tuple a b) b where
    snd = T.snd

-- | Map a function over the first field of a pair.
first :: forall a. (a -> a) -> Pair a -> Pair a
first f (Pair a b) = Pair (f a) b

-- | Map a function over the second field of a pair.
second :: forall a. (a -> a) -> Pair a -> Pair a
second f (Pair a b) = Pair a (f b)

-- | Swaps the elements in a pair.
swap :: forall a. Pair a -> Pair a
swap (Pair a b) = Pair b a

instance showPair :: Show a => Show (Pair a) where
    show (Pair a b) = "(Pair " <> show a <> " " <> show b <> ")"

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
    extend f p = Pair (f p) (f (swap p))

instance comonadPair :: Comonad Pair where
    extract (Pair a b) = a

instance arbitraryPair :: Arbitrary a => Arbitrary (Pair a) where
    arbitrary = Pair <$> arbitrary <*> arbitrary

instance coarbitraryPair :: Coarbitrary a => Coarbitrary (Pair a) where
    coarbitrary (Pair a b) = coarbitrary b <<< coarbitrary a 
