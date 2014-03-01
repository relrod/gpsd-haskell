-----------------------------------------------------------------------------
-- |
-- Copyright : (c) 2014 Ricky Elrod
-- License : BSD3
--
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
--
-- This module encapsulates a connection to the GPSD server, via io-streams.
----------------------------------------------------------------------------

module Network.GPSD.Connection
  ( connectGPSD
  ) where

import Network.GPSD.Config

import Data.ByteString (ByteString)
import Network.Socket
import System.IO.Streams hiding (connect)

-- | Connect to a GPSD server. Does not block, and instead allows direct access
-- to the underlying 'InputStream' and 'OutputStream'.
connectGPSD :: GPSDConfig
            -> IO (InputStream ByteString, OutputStream ByteString)
connectGPSD (GPSDConfig h p) = withSocketsDo $ do
  addrinfo <- getAddrInfo Nothing (Just h) (Just p)
  let serverAddr = addrAddress (head addrinfo)
  s <- socket AF_INET Stream defaultProtocol
  connect s serverAddr
  (i, o) <- socketToStreams s
  return (i, o)
