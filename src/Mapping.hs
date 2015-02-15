{-# LANGUAGE OverloadedStrings #-}
module Mapping where

import Prelude hiding (show, unwords, null)
import Data.Text (Text, unwords, null)
import Data.Monoid ((<>))

import Mode
import ShowText

data MapUnique = MapUnique | MapNoUnique
               deriving Eq

instance ShowText MapUnique where
  show MapUnique = "<unique>"
  show MapNoUnique = ""

data MapSilent = MapSilent | MapNoSilent
               deriving Eq

instance ShowText MapSilent where
  show MapSilent = "<silent>"
  show MapNoSilent = ""

data Mapping =
     Mapping { mapName    :: Text
             , mapRepText :: Text
             , mapUnique  :: MapUnique
             , mapSilent  :: MapSilent
             , mapMode    :: Mode
     } deriving Eq

instance ShowText Mapping where
  show m = unwords (filter (not . null)
          [ show (mapMode m) <> "noremap"
          , show (mapUnique m)
         <> show (mapSilent m)
          , mapName m
          , mapRepText m
          ])

defaultMapping :: Mapping
defaultMapping
  = Mapping { mapName    = ""
            , mapRepText = ""
            , mapUnique  = MapUnique
            , mapSilent  = MapSilent
            , mapMode    = NormalMode
  }

