{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
module Ipnspector.Server where

  import Network.Wai
  import Network.Wai.Handler.Warp
  import Network.Wai.Logger (withStdoutLogger, ApacheLogger)
  import Network.HTTP.Types (status200)  
  import Blaze.ByteString.Builder (copyByteString, fromByteString)
  import Data.IP
  import Data.IP.RouteTable as IP
  import qualified Data.Text as T
  import qualified Data.ByteString.Char8 as C

  server :: IPRTable IPv4 [Char] -> Application
  server trie' req response = do
      response $
        case pathInfo req of
          x -> ip trie' $ T.unpack $ head x

  copyBS x = case x of
    Just a -> copyByteString $ C.pack a
    Nothing -> copyByteString "Not present"

  ip trie' x = responseBuilder status200 [("Content-Type", "text/plain")] 
    $ copyBS $ IP.lookup (read x) trie'