## Module Data.Pair

#### `Pair`

``` purescript
data Pair a
  = Pair a a
```

A pair of objects of the same type.

##### Instances
``` purescript
HasFst (Pair a) a
HasSnd (Pair a) a
(Show a) => Show (Pair a)
(Eq a) => Eq (Pair a)
(Ord a) => Ord (Pair a)
(Bounded a) => Bounded (Pair a)
Functor Pair
Apply Pair
Applicative Pair
(Semigroup a) => Semigroup (Pair a)
(Monoid a) => Monoid (Pair a)
Foldable Pair
Traversable Pair
(Lazy a) => Lazy (Pair a)
Extend Pair
Comonad Pair
```

#### `HasFst`

``` purescript
class HasFst t a where
  fst :: t -> a
```

A type class representing having a first field and extracting it.

##### Instances
``` purescript
HasFst (Pair a) a
HasFst (Tuple a b) a
```

#### `HasSnd`

``` purescript
class HasSnd t a where
  snd :: t -> a
```

A type class representing having a second field with an extraction 
operator.

##### Instances
``` purescript
HasSnd (Pair a) a
HasSnd (Tuple a b) b
```

#### `first`

``` purescript
first :: forall a. (a -> a) -> Pair a -> Pair a
```

Map a function over the first field of a pair.

#### `second`

``` purescript
second :: forall a. (a -> a) -> Pair a -> Pair a
```

Map a function over the second field of a pair.


