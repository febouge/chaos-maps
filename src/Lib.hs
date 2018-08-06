module Lib
    ( plotChaoticMap
    , plotBifurcationDiagram
    , plotLyapunovExponent
    , plotCowebSeries
    ) where

import           Chaos.Draw
import           Chaos.Maps
import           Chaos.Types

plotChaoticMap :: IO ()
plotChaoticMap = plot2dWithLines chaoticMapEvaluation "./examples/temporal.png"
  where
    chaoticMapEvaluation = temporalEvolution mapConfig
    mapConfig = TemporalConditions LogisticMap 0.5 100 3.2

plotBifurcationDiagram :: IO ()
plotBifurcationDiagram = plot2d bifurcationDiagramEvaluation "./examples/bifurcation.png"
  where
    bifurcationDiagramEvaluation = bifurcationDiagram mapConfig
    mapConfig = DiagramConditions LogisticMap [0,(0.01)..3.99] 0.5 100 1000

plotLyapunovExponent :: IO ()
plotLyapunovExponent = plot2d lyapunovExponentEvaluation "./examples/lyapunov.png"
  where
    lyapunovExponentEvaluation = calculateLyapunov mapConfig
    mapConfig = DiagramConditions LogisticMap [0,(0.001)..3.99] 0.5 500 10000

plotCowebSeries :: IO ()
plotCowebSeries = plotCoweb cowebEvaluation [0, (0.001)..0.999] "./examples/coweb.png"
  where
    cowebEvaluation = cowebSeries mapConfig
    mapConfig = TemporalConditions LogisticMap 0.2 500 3.24
