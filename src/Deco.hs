
{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeApplications #-}

module Deco where

import Data.Aeson
import Data.Aeson.Types (Parser)
import Data.Text (Text)
import qualified Data.Text as T

data Switch = Unchecked | Checked

data Deco (s :: Switch) t where
  U :: Deco 'Unchecked t
  T :: t -> Deco 'Checked t

fromT :: Deco 'Checked t -> t
fromT (T x) = x

deriving instance Show t => Show (Deco s t)

deriving instance Eq t => Eq (Deco s t)


instance (ToJSON t) => ToJSON (Deco 'Unchecked t) where
  toJSON U  = object ["tag" .= ("Deco" :: Text), "value" .= ("unchecked":: Text)]

instance (ToJSON t) => ToJSON (Deco 'Checked t) where
  toJSON (T v)  = object ["tag" .= ("Deco" :: Text), "value" .= toJSON v]

instance FromJSON t => FromJSON (Deco 'Unchecked t) where
  parseJSON = withObject "Deco" $ \obj -> do
    tag <- obj .: "tag"
    val <- obj .: "value"
    if tag == ("Deco" :: Text) && val == ("unchecked" :: Text)
      then pure U
      else fail "Expected Deco with value \"unchecked\""

instance FromJSON t => FromJSON (Deco 'Checked t) where
  parseJSON = withObject "Deco" $ \obj -> do
    tag <- obj .: "tag"
    if tag == ("Deco" :: Text)
      then T <$> obj .: "value"
      else fail "Expected Deco with value payload"
      