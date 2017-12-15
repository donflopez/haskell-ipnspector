module Ipnspector.File where
  
  beginsWithSharp (c:_) = c == '#'

  notBeginsWithSharp = not . beginsWithSharp

  loadIpsFrom = (filter notBeginsWithSharp . lines <$>) . readFile