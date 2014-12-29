{-# LANGUAGE OverloadedStrings #-}
module Network.GPSD where

import Control.Lens
import Data.Aeson (FromJSON, ToJSON)
import qualified Data.ByteString.Char8 as B
import Network.GPSD.Types
import Network.Socket hiding (send)
import Pipes
import Pipes.Aeson (DecodingError)
import Pipes.Aeson.Unchecked
import qualified Pipes.ByteString as PB
import Pipes.Network.TCP hiding (connect)
--import Pipes.Parse

connectGPSD :: IO Socket
connectGPSD = withSocketsDo $ do
  addrinfo <- getAddrInfo Nothing (Just "localhost") (Just "2947")
  let serverAddr = addrAddress (head addrinfo)
  s <- socket AF_INET Stream defaultProtocol
  connect s serverAddr
  send s "?WATCH={\"enable\":true, \"json\":true}"
  return s

socketToPipe :: MonadIO m
             => Socket
             -> Proxy x' x () B.ByteString m ()
socketToPipe s = fromSocket s 4096

-- | Connect to the GPSD server and send the watch command. Print out each line
-- as it comes in.
debug :: IO ()
debug = do
  s <- connectGPSD
  runEffect $ for (socketToPipe s) (lift . B.putStrLn)

footest :: (FromJSON m, ToJSON m)
        => Producer B.ByteString IO ()
        -> Producer m IO (Either (DecodingError, Producer B.ByteString IO ()) ())
footest = view decoded

skipErrors :: (FromJSON m, ToJSON m)
           => Producer PB.ByteString IO ()
           -> Producer m IO ()
skipErrors p = do
  x <- footest p
  case x of
   Right r -> return r
   Left (_, p') -> do
     x' <- lift $ PB.nextByte p'
     case x' of
      Right (_, p'') -> skipErrors p''
      Left r -> return r

debugParse :: Socket -> IO ()
debugParse s =
  runEffect $
    for (skipErrors (socketToPipe s) :: Producer Tpv IO ()) (\x -> lift . print $ (x ^. time))
