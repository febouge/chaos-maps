module Draw
    ( plot2dWithLines
    , plot2d
    , plotCoweb
    ) where

import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo
import Types

plot2dWithLines :: Series -> FilePath -> IO ()
plot2dWithLines series exportFile = toFile def exportFile $ do
    layout_title .= "Population evolution"
    setColors [opaque blue, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) series
    plot (line "Helper line" [pointsToPlot])
    plot (points "Temp series" pointsToPlot)

plot2d :: Series -> FilePath -> IO ()
plot2d series exportFile = toFile def exportFile $ do
    layout_title .= "Bifurcation diagram"
    setColors [opaque blue, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) series
    plot (points "Bifurcation diagram" pointsToPlot)

plotCoweb :: CowebResult -> FilePath -> IO ()
plotCoweb cowebResult exportFile = toFile def exportFile $ do
    layout_title .= "Coweb diagram"
    setColors [opaque red, opaque green, opaque black]
    let seriesToPlot = series cowebResult
    let pointsToPlot = map (\p -> (x p, y p)) seriesToPlot
    let xRange = [0.0,(0.01)..0.99]
    let auxStraightLine = map (\x -> (x, x)) xRange
    let chaoticMapPartial = (chaoticMap cowebResult) (r cowebResult)
    let auxChaoticMap = map (\x -> (x, chaoticMapPartial x)) xRange
    plot (line "Coweb plot" [pointsToPlot])
    plot (line "Chaotic map curve" [auxChaoticMap])
    plot (line "f(x) = x" [auxStraightLine])
