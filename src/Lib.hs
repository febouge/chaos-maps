module Lib
    ( plotMap
    ) where

import ChaoticMaps
import Draw
import Types

plotMap :: IO ()
plotMap = plot2d chaoticMapEvaluation
  where chaoticMapEvaluation = temporalEvolution logisticMap mapConfig
        mapConfig = TemporalConditions 0.5 100 3.2
