module PoemLines where

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"
sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

mySplit :: String -> Char -> [String]
mySplit s sep = go s [] where
  go s list
   | s == [] = list
   | otherwise = go (drop 1 (dropWhile (/= sep) s)) (list ++ (:[])(takeWhile (/= sep) s))

--ex.1
myWords :: String -> [String]
myWords s = mySplit s ' '

--ex.2
myLines :: String -> [String]
myLines = \s -> mySplit s '\n'

shouldEqual =
 [ "Tyger Tyger, burning bright"
 , "In the forests of the night"
 , "What immortal hand or eye"
 , "Could frame thy fearful symmetry?"
 ]

main :: IO ()
main = print $ "Are they equal? " ++ show (myLines sentences == shouldEqual)
