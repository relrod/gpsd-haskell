-----------------------------------------------------------------------------
-- |
-- Copyright : (c) 2014 Ricky Elrod
-- License : BSD3
--
-- Maintainer : Ricky Elrod <ricky@elrod.me>
-- Stability : experimental
--
-- Provides data types used by 'Network.GPSD'. These are what GPSD's JSON
-- stream parse into.
----------------------------------------------------------------------------

module Network.GPSD.Types (
  ) where

--Just "{\"class\":\"TPV\",\"tag\":\"MID2\",\"device\":\"/dev/ttyUSB0\",\"mode\":1,\"time\":\"2014-02-22T22:23:57.000Z\",\"ept\":0.005}\r\n"

--Just "{\"class\":\"SKY\",\"tag\":\"MID4\",\"device\":\"/dev/ttyUSB0\",\"time\":\"2014-02-22T22:25:11.000Z\",\"xdop\":0.86,\"ydop\":1.11,\"vdop\":2.43,\"tdop\":1.51,\"hdop\":1.80,\"gdop\":3.19,\"pdop\":2.81,\"satellites\":[{\"PRN\":20,\"el\":39,\"az\":267,\"ss\":18,\"used\":true},{\"PRN\":31,\"el\":52,\"az\":51,\"ss\":23,\"used\":true},{\"PRN\":16,\"el\":43,\"az\":199,\"ss\":16,\"used\":true},{\"PRN\":14,\"el\":14,\"az\":123,\"ss\":13,\"used\":true}]}\r\n"


--class device tag time
