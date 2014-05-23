{-# LANGUAGE TemplateHaskell #-}
-----------------------------------------------------------------------------
-- |
-- Copyright : (c) 2014 Ricky Elrod
-- License : BSD3
--
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
--
-- Provides lenses for GPSD types.
----------------------------------------------------------------------------

module Network.GPSD.Lens where

import Control.Lens
import Network.GPSD.Config

makeLenses ''GPSDConfig
