-----------------------------------------------------------------------------
-- |
-- Copyright : (c) 2014 Ricky Elrod
-- License : BSD3
--
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
--
-- Contains types for configuring how we talk to the GPSD server.
----------------------------------------------------------------------------

module Network.GPSD.Config
  ( GPSDConfig (..)
  , defaultConfig
  ) where

-- TODO: lens?
-- | Configures how we should talk with the GPSD server.
data GPSDConfig = GPSDConfig {
    _hostname :: String -- ^ The hostname to connect to.
  , _port :: String     -- ^ The port to connect to.
                        -- ^ Yes, it is a <https://hackage.haskell.org/package/network-2.4.1.2/docs/Network-Socket.html#v:getAddrInfo string>.
  } deriving (Eq, Show)

defaultConfig :: GPSDConfig
defaultConfig = GPSDConfig "localhost" "2947"
