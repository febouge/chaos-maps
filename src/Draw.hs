module Draw
    ( plot2dWithLines
    , plot2d
    , plotCoweb
    ) where


import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo
import Types

type AuxValues = [Double]

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
    plot (points "" pointsToPlot)


plotCoweb :: Series -> AuxValues -> FilePath -> IO ()
plotCoweb series auxValues exportFile = toFile def exportFile $ do
    layout_title .= "Coweb diagram"
    setColors [opaque black, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) series
    let auxStraightLine = map (\x -> (x, x)) auxValues
    plot (line "Aux Line" [auxStraightLine])
    plot (line "Coweb plot" [pointsToPlot])
