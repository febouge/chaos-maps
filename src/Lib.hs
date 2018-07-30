module Lib
    ( plotChaoticMap
    , plotBifurcationDiagram
    , plotLyapunovExponent
    , plotCowebSeries
    ) where

import Chaos.Maps
import Chaos.Draw
import Chaos.Types

plotChaoticMap :: IO ()
plotChaoticMap = plot2dWithLines chaoticMapEvaluation "temporal.png"
  where chaoticMapEvaluation = temporalEvolution logisticMap mapConfig
        mapConfig = TemporalConditions 0.5 100 3.2

plotBifurcationDiagram :: IO ()
plotBifurcationDiagram = plot2d bifurcationDiagramEvaluation "bifurcation.png"
  where bifurcationDiagramEvaluation = bifurcationDiagram logisticMap mapConfig
        mapConfig = BifurcationConditions [0,(0.01)..3.99] 0.5 100 1000

plotLyapunovExponent :: IO ()
plotLyapunovExponent = plot2d lyapunovExponentEvaluation "lyapunov.png"
  where lyapunovExponentEvaluation = calculateLyapunov lyapunovLogistic logisticMap mapConfig
        mapConfig = BifurcationConditions [0,(0.001)..3.99] 0.5 500 10000

plotCowebSeries :: IO ()
plotCowebSeries = plotCoweb cowebEvaluation [0, (0.001)..0.999] "coweb.png"
  where cowebEvaluation = cowebSeries logisticMap mapConfig
        mapConfig = TemporalConditions 0.2 500 3.24
