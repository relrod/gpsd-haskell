{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Network.GPSD.Types where

import Control.Applicative
import Control.Lens
import Data.Aeson
import Data.Monoid (mempty)

data TPV =
  TPV { _tpvClass  :: String
      , _tpvTag    :: Maybe String
      , _tpvDevice :: Maybe String
      , _tpvMode   :: Int
      , _tpvTime   :: Maybe String
      , _tpvEpt    :: Maybe Double
      , _tpvLat    :: Maybe Double
      , _tpvLon    :: Maybe Double
      , _tpvAlt    :: Maybe Double
      , _tpvEpx    :: Maybe Double
      , _tpvEpy    :: Maybe Double
      , _tpvEpv    :: Maybe Double
      , _tpvTrack  :: Maybe Double
      , _tpvSpeed  :: Maybe Double
      , _tpvClimb  :: Maybe Double
      , _tpvEpd    :: Maybe Double
      , _tpvEps    :: Maybe Double
      , _tpvEpc    :: Maybe Double
      } deriving (Eq, Ord, Show)

makeFields ''TPV

instance FromJSON TPV where
  parseJSON (Object o) =
    TPV <$>
      o .:  "class"  <*>
      o .:? "tag"    <*>
      o .:? "device" <*>
      o .:  "mode"   <*>
      o .:? "time"   <*>
      o .:? "ept"    <*>
      o .:? "lat"    <*>
      o .:? "lon"    <*>
      o .:? "alt"    <*>
      o .:? "epx"    <*>
      o .:? "epy"    <*>
      o .:? "epv"    <*>
      o .:? "track"  <*>
      o .:? "speed"  <*>
      o .:? "climb"  <*>
      o .:? "epd"    <*>
      o .:? "eps"    <*>
      o .:? "epc"
  parseJSON _ = mempty
