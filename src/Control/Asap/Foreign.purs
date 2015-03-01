module Control.Asap.Foreign
  ( AsapForeign(..)
  , asap
  ) where

import qualified Control.Asap.Node as Node
import qualified Control.Asap.Browser as Browser

foreign import data AsapForeign :: *

foreign import select """
  function select(nodeImpl) {
    return function(browserImpl) {
      var asap = nodeImpl || browserImpl;
      if (typeof asap !== "function") {
        throw new Error("No asap implementation available for this platform.");
      }
      return asap;
    };
  }""" :: Node.AsapForeign -> Browser.AsapForeign -> AsapForeign

asap :: AsapForeign
asap = select Node.asap Browser.asap
