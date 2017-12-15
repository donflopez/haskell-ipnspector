module Main where

import Network.Wai.Logger (withStdoutLogger)
import Network.Wai.Handler.Warp (run)
import System.Environment
import Ipnspector.Server
import Ipnspector.Trie

main :: IO ()
main = do
  trie' <- loadTrieFromFile "firehol_level1.netset"
  trie'' <- loadFileIntoTrie trie' "firehol_level2.netset"
  run 3000 $ server trie''