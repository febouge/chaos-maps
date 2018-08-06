module Main where

import           Lib

main :: IO ()
main = do
  plotChaoticMap
  plotBifurcationDiagram
  plotCowebSeries
  plotLyapunovExponent
