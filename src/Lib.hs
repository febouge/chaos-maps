module Lib
    ( plotMap
    , plotBifurcationDiagram
    ) where

import ChaoticMaps
import Draw
import Types

plotMap :: IO ()
plotMap = plot2dWithLines chaoticMapEvaluation "example.png"
  where chaoticMapEvaluation = temporalEvolution logisticMap mapConfig
        mapConfig = TemporalConditions 0.5 100 3.2

plotBifurcationDiagram :: IO ()
plotBifurcationDiagram = plot2d bifurcationDiagramEvaluation "example.png"
  where bifurcationDiagramEvaluation = bifurcationDiagram logisticMap mapConfig
        mapConfig = BifurcationConditions [0,(0.01)..3.99] 0.5 100 1000
