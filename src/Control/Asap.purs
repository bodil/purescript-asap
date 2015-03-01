module Control.Asap
  ( schedule
  , Asap(..)
  ) where

import Control.Monad.Eff
import Control.Asap.Foreign

foreign import data Asap :: !

foreign import scheduleP """
  function scheduleP(asap) {
    return function schedule(task) {
      return function() {
        asap(task);
      };
    };
  }""" :: forall e. AsapForeign -> Eff (asap :: Asap | e) Unit -> Eff (asap ::Asap | e) Unit

--| Takes an effect of type `Eff e Unit` and executes it as soon as possible,
--| but after the current event has completed, and after previously
--| scheduled jobs.
schedule :: forall e. Eff (asap :: Asap | e) Unit -> Eff (asap ::Asap | e) Unit
schedule = scheduleP asap
