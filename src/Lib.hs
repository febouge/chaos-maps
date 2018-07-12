module Lib
    ( plotMap
    , plotBifurcationDiagram
    , plotLyapunovExponent
    ) where

import ChaoticMaps
import Draw
import Types

plotMap :: IO ()
plotMap = plot2dWithLines chaoticMapEvaluation "temporal.png"
  where chaoticMapEvaluation = temporalEvolution logisticMap mapConfig
        mapConfig = TemporalConditions 0.5 100 3.2

plotBifurcationDiagram :: IO ()
plotBifurcationDiagram = plot2d bifurcationDiagramEvaluation "bifurcation.png"
  where bifurcationDiagramEvaluation = bifurcationDiagram cubicMap mapConfig
        mapConfig = BifurcationConditions [0,(0.01)..3.99] 0.5 100 1000

plotLyapunovExponent :: IO ()
plotLyapunovExponent = plot2d lyapunovExponentEvaluation "lyapunov.png"
  where lyapunovExponentEvaluation = calculateLyapunov lyapunovLogistic logisticMap mapConfig
        mapConfig = BifurcationConditions [0,(0.001)..3.99] 0.5 500 10000
