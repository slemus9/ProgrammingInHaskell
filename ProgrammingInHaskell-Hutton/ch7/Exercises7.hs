{- 1. Show how the list comprehension [f x | x ← xs, p x ]
can be re-expressed using the higher-order functions map and filter
-}
mapAndFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapAndFilter f p = (map f).(filter p)

{- 2. Without looking at the definitions from the standard prelude,
define the higher-order functions all , any, takeWhile and dropWhile.
-}

-- 2.1. All
all' :: (a -> Bool) -> [a] -> Bool
all' p = foldr (\x y -> p x && y) True

-- 2.2. Any
any' :: (a -> Bool) -> [a] -> Bool
any' p = foldr (\x y -> p x || y) False

-- 2.3. TakeWhile (Check if it's correct)
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' p = foldr (\x y -> if p x then x : y else []) []

{-
takeWhile' _ [] = []
takeWhile' p (x : xs)
  | p x = x : takeWhile' p xs
  | otherwise = []
-}

-- 2.4. DropWhile
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' p lx@(x : xs)
  | p x = dropWhile' p xs
  | otherwise = lx

-- 3. Redefine the functions map f and filter p using foldr.
map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

filter' :: (a -> Bool) -> [a] -> [a]
filter' p = foldr (\x y -> if p x then x : y else y) []

{- 4. Using foldl , define a function dec2int :: [Int ] → Int
that converts a decimal number into an integer.
-}
dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10*x + y) 0

{- 5. Explain why the following definition is invalid:
  sumsqreven = compose [sum, map(^2), filter even]

Looking at the type of each function we can see the following:
  filter even :: Integral a => [a] -> a
  map (^2) :: Num b => [b] -> [b]
  sum :: Num c => [c] -> c

The composition between these functions results in:
  sum.(map (^2)).(filter even) :: Integral c => [c] -> c

However, the function compose is of type:
  compose :: [a -> a] -> (a -> a)

Meaning that compose outputs a function that receives a given type
and returns a result of the same type. Hence, we cannot call compose
over that particular array, since its composition results in a function
that returns a value that is of different type than the received argument
([c] -> c)
-}

{- 6. Without looking at the standard prelude, define the higher-order library
function curry that converts a function on pairs into a curried function,
and conversely, the function uncurry that converts a curried function
with two arguments into a function on pairs.
-}
curry' :: ((a, b) -> c) -> (a -> b -> c)
curry' f = \a -> (\b -> f(a,b))

uncurry' :: (a -> b -> c) -> ((a, b) -> c)
uncurry' f = \(a, b) -> f a b

{- 7. A higher-order function unfold that encapsulates a simple pattern of
recursion for producing a list can be defined as follows:
-}
unfold :: (a -> Bool) -> (a -> b) -> (a -> a) -> a -> [b]
unfold p h t x
  | p x = []
  | otherwise = h x : unfold p h t (t x)
-- Redefine the functions chop8 , map f and iterate f using unfold .
-- Example: int2bin = unfold (== 0) (`mod`2) (`div`2)
type Bit = Int

-- 7.1. For chop8
chop8' :: [Bit] -> [[Bit]]
chop8' = unfold null (take 8) (drop 8)

-- 7.2. For map f
map'' :: (a -> b) -> [a] -> [b]
map'' f = unfold null (f.head) tail

-- 7.3. For iterate f
iterate' :: (a -> a) -> a -> [a]
iterate' f = unfold (\_ -> False) id f

{- 8. Modify the string transmitter program to detect simple transmission
errors using parity bits.
-}
