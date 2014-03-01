-----------------------------------------------------------------------------
-- |
-- Copyright : (c) 2014 Ricky Elrod
-- License : BSD3
--
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
--
-- Provides a Haskell interface to the
-- <http://gpsd.berlios.de/client-howto.html GPSD wire protocol>.
--
-- This module simply re-exports all public modules within the project.
----------------------------------------------------------------------------

module Network.GPSD
  ( module G
  ) where

import Network.GPSD.Config as G
import Network.GPSD.Connection as G
