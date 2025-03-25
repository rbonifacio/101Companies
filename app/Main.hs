{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
module Main where

import Deco
import Syntax
import Sample
import HaskellEncoder ()
import HaskellDecoder ()

import Data.Aeson (decode)
import Data.Aeson.Encode.Pretty (encodePretty)

import Control.Exception (assert)

import qualified Data.ByteString.Lazy.Char8 as B

main :: IO ()
main = do 
  let toJson = encodePretty sampleCompanyC
  let fromJson = decode toJson :: Maybe (Company 'Checked)
  putStrLn "Serialized JSON (pretty-printed):"
  B.putStrLn toJson
  putStrLn "Checking if encoding and decoding preserve the value..."
  assert (Just sampleCompanyC == fromJson) (putStrLn "Success: encode . decode == id")
