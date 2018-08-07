module Main where

import           Chaos
import           Options.Applicative (customExecParser, prefs, showHelpOnEmpty)

main :: IO ()
main = run =<< customExecParser (prefs showHelpOnEmpty) cliOpts
