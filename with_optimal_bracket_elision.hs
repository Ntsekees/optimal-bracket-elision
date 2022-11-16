{-# LANGUAGE UnicodeSyntax #-}

-- COPYRIGHT LICENSE: CC0 version 1.0. For reading a copy of this license, please see the file ⟪CC0 1.0 LICENSE.txt⟫.
-- SPDX-License-Identifier: CC0-1.0

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
    Just s -> putStrLn $
      (wordwise with_optimal_bracket_elision s) ++ "\n"

nth :: Int -> [a] -> Maybe a
nth _ []     = Nothing
nth i (x : l) =
  if i == 0
  then Just x
  else nth (i - 1) l

wordwise :: ([String] -> [String]) -> String -> String
wordwise f = intercalate " " . f . splitOn " "

with_optimal_bracket_elision :: [String] -> [String]
with_optimal_bracket_elision bl =  -- ⟨𝕋⟩ Bracket List
  let
    bl' = bl ++ [""]
  in
    with_optimal_bracket_elision' bl' [] 0 ("", 0)

with_optimal_bracket_elision' ::
  [String] -> [String] -> Int -> (String, Int) -> [String]
with_optimal_bracket_elision'
  bl   -- ⟨𝕋⟩ Bracket List
  obl  -- ⟨𝕋⟩ Optimal Bracket List
  si   -- ℕ Start Index
  c    -- ⁅𝕋､ℕ⁆ Candidate
  =
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
next_kept_bracket
  (b : l)   -- 𝕋 Bracket : ⟨𝕋⟩ List
  i         -- ℕ Index
  dbs       -- 𝕊 Discarded Bracket Set
  (cb, ci)  -- ⁅𝕋､ℕ⁆ Candidate Bracket､ Candidate Index
  | b == ""   =
    if i == 0
    then Nothing
    else Just (cb, ci)
  | ((b /= cb) && not (elem b dbs)) =
    next_kept_bracket l (i + 1) (Set.insert cb dbs) (b, i)
  | otherwise =
    next_kept_bracket l (i + 1) dbs (cb, ci)


