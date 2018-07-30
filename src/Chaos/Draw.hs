module Chaos.Draw
    ( plot2dWithLines
    , plot2d
    , plotCoweb
    ) where

import Chaos.Types
import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo

plot2dWithLines :: Series -> FilePath -> IO ()
plot2dWithLines pointSeries exportFile = toFile def exportFile $ do
    layout_title .= "Iteration evolution"
    setColors [opaque blue, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) pointSeries
    plot (line "Helper line" [pointsToPlot])
    plot (points "Temp series" pointsToPlot)

plot2d :: Series -> FilePath -> IO ()
plot2d pointSeries exportFile = toFile def exportFile $ do
    layout_title .= "Bifurcation diagram"
    setColors [opaque blue, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) pointSeries
    plot (points "Bifurcation diagram" pointsToPlot)

plotCoweb :: CowebResult -> [Double] -> FilePath -> IO ()
plotCoweb cowebResult auxValues exportFile = toFile def exportFile $ do
    layout_title .= "Coweb diagram"
    setColors [opaque red, opaque green, opaque black]
    let seriesToPlot = series cowebResult
    let pointsToPlot = map (\p -> (x p, y p)) seriesToPlot
    let auxStraightLine = map (\p -> (p, p)) auxValues
    let chaoticMapPartial = (chaoticMap cowebResult) (r cowebResult)
    let auxChaoticMap = map (\p -> (p, chaoticMapPartial p)) auxValues
    plot (line "Coweb plot" [pointsToPlot])
    plot (line "Chaotic map curve" [auxChaoticMap])
    plot (line "f(x) = x" [auxStraightLine])
