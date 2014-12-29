{-# LANGUAGE OverloadedStrings #-}
module Network.GPSD where

import Control.Lens
import qualified Data.ByteString.Char8 as B
import Data.Char
import Network.GPSD.Types
import Network.Socket hiding (send)
import Pipes
import Pipes.Aeson (DecodingError)
import Pipes.Aeson.Unchecked
import Pipes.Network.TCP hiding (connect)
import Pipes.Parse

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

foo :: MonadIO m => Parser Tpv m ()
foo = foldAllM (const $ return (return ())) (return ()) return

bar :: Parser B.ByteString IO ()
bar = zoom decoded foo

footest :: Socket -> Producer Tpv IO (Either (DecodingError, Producer B.ByteString IO ()) ())
footest s =
  view decoded (socketToPipe s)

debugParse
  :: IO (Either (DecodingError, Producer B.ByteString IO ()) ())
debugParse = do
  s <- connectGPSD
  runEffect $ for (footest s) (\x -> lift . print $ (x ^. lat))
