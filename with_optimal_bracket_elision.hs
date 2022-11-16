{-# LANGUAGE UnicodeSyntax #-}

import System.Environment
import Data.List.Split (splitOn)
import Data.List (intercalate)
import qualified Data.Set as Set

{- ========================================================== -}

main :: IO ()
main = do
  args <- getArgs
  case nth 0 args of
    Nothing -> error "⚠ No argument provided! ⚠"
    Just s -> putStrLn ((intercalate " " (
      with_optimal_bracket_elision (splitOn " " s))) ++ "\n")
    
     
nth :: Int -> [a] -> Maybe a
nth _ []     = Nothing
nth i (x:xl) =
  if i == 0
  then Just x
  else nth (i - 1) xl

with_optimal_bracket_elision :: [String] -> [String]
with_optimal_bracket_elision bl =
  let
    bl' = bl ++ [""]
  in
    with_optimal_bracket_elision' bl' [] 0 ("", 0)

with_optimal_bracket_elision' ::
  [String] -> [String] -> Int -> (String, Int) -> [String]
with_optimal_bracket_elision' bl obl si c =
  case next_kept_bracket (drop si bl) 0 Set.empty c of
    Nothing -> obl
    Just (cb', ci') ->
      let
        si' = si + ci' + 1
        obl' = obl ++ [cb']
      in
        with_optimal_bracket_elision' bl obl' si' (cb', ci')

next_kept_bracket ::
  [String] -> Int -> Set.Set(String) -> (String, Int)
  -> Maybe((String, Int))
next_kept_bracket (b : l) i dbs (cb, ci)
 | b == ""   =
    if i == 0
    then Nothing
    else Just (cb, ci)
 | ((b /= cb) && not (elem b dbs)) =
    next_kept_bracket l (i + 1) (Set.insert cb dbs) (b, i)
 | otherwise =
    next_kept_bracket l (i + 1) dbs (cb, ci)


