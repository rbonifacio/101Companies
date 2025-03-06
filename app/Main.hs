{-# LANGUAGE OverloadedStrings #-}
module Main where

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
  let toJson = encodePretty sampleCompany
  let fromJson = decode toJson :: Maybe Company
  putStrLn "Serialized JSON (pretty-printed):"
  B.putStrLn toJson
  putStrLn "Checking if encoding and decoding preserve the value..."
  assert (Just sampleCompany == fromJson) (putStrLn "Success: encode . decode == id")
