{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Network.GPSD.Types where

import Control.Applicative
import Control.Lens hiding ((.=))
import Data.Aeson
import Data.Monoid (mempty)

data Tpv =
  Tpv { tpvClass  :: String
      , tpvTag    :: Maybe String
      , tpvDevice :: Maybe String
      , tpvMode   :: Int
      , tpvTime   :: Maybe String
      , tpvEpt    :: Maybe Double
      , tpvLat    :: Maybe Double
      , tpvLon    :: Maybe Double
      , tpvAlt    :: Maybe Double
      , tpvEpx    :: Maybe Double
      , tpvEpy    :: Maybe Double
      , tpvEpv    :: Maybe Double
      , tpvTrack  :: Maybe Double
      , tpvSpeed  :: Maybe Double
      , tpvClimb  :: Maybe Double
      , tpvEpd    :: Maybe Double
      , tpvEps    :: Maybe Double
      , tpvEpc    :: Maybe Double
      } deriving (Eq, Ord, Show)

makeFields ''Tpv

instance FromJSON Tpv where
  parseJSON (Object o) =
    Tpv <$>
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

instance ToJSON Tpv where
     toJSON (Tpv cl ta de mo ti ep la lo al epx' epy' epv' tr sp cli epd' eps' epc') =
       object [ "class"  .= cl
              , "tag"    .= ta
              , "device" .= de
              , "mode"   .= mo
              , "time"   .= ti
              , "ept"    .= ep
              , "lat"    .= la
              , "lon"    .= lo
              , "alt"    .= al
              , "epx"    .= epx'
              , "epy"    .= epy'
              , "epv"    .= epv'
              , "track"  .= tr
              , "speed"  .= sp
              , "climb"  .= cli
              , "epd"    .= epd'
              , "eps"    .= eps'
              , "epc"    .= epc'
              ]

data Satellite =
  Satellite { satelliteUsed :: Bool
            , satelliteSs   :: Integer
            , satelliteAz   :: Integer
            , satelliteEl   :: Integer
            , satellitePrn  :: Integer
            } deriving (Eq, Ord, Show)

makeFields ''Satellite

instance FromJSON Satellite where
  parseJSON (Object o) =
    Satellite <$>
      o .: "used" <*>
      o .: "ss"   <*>
      o .: "az"   <*>
      o .: "el"   <*>
      o .: "PRN"
  parseJSON _ = mempty

data Sky =
  Sky { skyClass      :: String
      , skyDevice     :: Maybe String
      , skyTag        :: Maybe String
      , skySatellites :: Maybe [Satellite]
      , skyPdop       :: Maybe Double
      , skyGdop       :: Maybe Double
      , skyHdop       :: Maybe Double
      , skyTdop       :: Maybe Double
      , skyVdop       :: Maybe Double
      , skyYdop       :: Maybe Double
      , skyXdop       :: Maybe Double
      , skyTime       :: Maybe String
      } deriving (Eq, Ord, Show)

makeFields ''Sky
