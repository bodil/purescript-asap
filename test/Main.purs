module Test.Main where

import Control.Asap
import Control.Monad.Eff.Ref
import Data.List (List(..), fromArray)
import Debug.Trace
import Test.Unit

main = runTest do
  test "scheduler runs tasks in correct order" do
    assertFn "unexpected result value" \done -> do
      out <- newRef Nil
      schedule $ modifyRef out $ Cons 2
      modifyRef out $ Cons 3
      schedule $ modifyRef out $ Cons 1
      schedule $ do
        result <- readRef out
        done $ result == fromArray [1, 2, 3]
