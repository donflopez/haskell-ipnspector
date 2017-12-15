{-# LANGUAGE OverloadedStrings #-}

module Ipnspector.Trie where
  import Data.Foldable
  import Data.IP
  import Data.IP.RouteTable as IP
  import Ipnspector.File

  insertIp tree ip = IP.insert ((read ip) :: AddrRange IPv4) ("present") tree

  insertFromList = foldl' insertIp

  loadTrieFromFile = (insertFromList IP.empty <$>) . loadIpsFrom

  loadFileIntoTrie trie' = (insertFromList trie' <$>) . loadIpsFrom
