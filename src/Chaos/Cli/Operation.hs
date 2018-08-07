module Chaos.Cli.Operation where

import           Chaos.Cli.Parser
import           Chaos.Map.Operation
import           Chaos.Map.Plot

plotChaoticMap :: TemporalIterationOptions -> IO ()
plotChaoticMap config = plot2dWithLines chaoticMapEvaluation file
  where
    chaoticMapEvaluation = temporalEvolution $ temporalConditions config
    file = plotExportFile config

plotBifurcationDiagram :: DiagramOptions -> IO ()
plotBifurcationDiagram config = plot2d bifurcationDiagramEvaluation file
  where
    bifurcationDiagramEvaluation = bifurcationDiagram $ diagramConditions config
    file = diagramExportFile config

plotLyapunovExponent :: DiagramOptions -> IO ()
plotLyapunovExponent config = plot2d lyapunovExponentEvaluation file
  where
    lyapunovExponentEvaluation = calculateLyapunov $ diagramConditions config
    file = diagramExportFile config

plotCowebSeries :: TemporalIterationOptions -> IO ()
plotCowebSeries config = plotCoweb cowebEvaluation [0, (0.001)..0.999] file
  where
    cowebEvaluation = cowebSeries $ temporalConditions config
    file = plotExportFile config
