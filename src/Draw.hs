module Draw
    ( plot2d
    ) where


import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Cairo
import Types


plot2d :: Series -> IO ()
plot2d series = toFile def "example1_big.png" $ do
    layout_title .= "Population evolution"
    setColors [opaque blue, opaque red]
    let pointsToPlot = map (\p -> (x p, y p)) series
    -- plot (line "Helper line" pointsToPlot)
    plot (points "Temp series" pointsToPlot)
