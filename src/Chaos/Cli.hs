module Chaos.Cli
    (
      run
    , module Chaos.Cli.Parser
    , module Chaos.Cli.Operation
    ) where

import           Chaos.Cli.Operation
import           Chaos.Cli.Parser

run :: PlotOptions -> IO ()
run (TemporalIteration config)  = plotChaoticMap config
run (CowebDiagram config)       = plotCowebSeries config
run (BifurcationDiagram config) = plotBifurcationDiagram config
run (LyapunovDiagram config)    = plotLyapunovExponent config
