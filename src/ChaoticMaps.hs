module ChaoticMaps
    ( logisticMap
    , cubicMap
    , lyapunovLogistic
    , lyapunovCubic
    , temporalEvolution
    , bifurcationDiagram
    , calculateLyapunov
    ) where

import Types
import Data.List (zip)

logisticMap :: ChaoticMap
logisticMap r x = r * x * (1 - x)

lyapunovLogistic :: LyapunovExponent
lyapunovLogistic r points = lyapunovSum / (fromIntegral $ length points)
  where lyapunovSum = foldl (\acc x -> acc + log(abs(r-2 * r * x))) 0.0 points

cubicMap :: ChaoticMap
cubicMap r x = r * x ** 3.0 + (1 - r) * x

lyapunovCubic :: LyapunovExponent
lyapunovCubic r points = lyapunovSum / (fromIntegral $ length points)
  where lyapunovSum = foldl (\acc x -> acc + log(abs(r*3*x**2)+1-r)) 0.0 points

temporalEvolution :: ChaoticMap -> TemporalConditions -> Series
temporalEvolution chaoticMap (TemporalConditions initialCondition n r) = map (\(x,y) -> Point x y) $ zip [0.0,1..nDouble] $ temporalIteration chaoticMap (TemporalConditions initialCondition n r)
  where nDouble = fromIntegral n


bifurcationDiagram :: ChaoticMap -> BifurcationConditions -> Series
bifurcationDiagram chaoticMap (BifurcationConditions [] ic ts mp ) = []
bifurcationDiagram chaoticMap (BifurcationConditions (r:rRange) ic ts mp ) = rAnalysis ++ bifurcationDiagram chaoticMap (BifurcationConditions rRange ic ts mp )
  where rAnalysis = map (\x -> Point r x) $ drop ts $ temporalIteration chaoticMap (TemporalConditions ic mp r)

calculateLyapunov :: LyapunovExponent -> ChaoticMap -> BifurcationConditions -> Series
calculateLyapunov lyap chaoticMap (BifurcationConditions [] ic ts mp ) = []
calculateLyapunov lyap chaoticMap (BifurcationConditions (r:rRange) ic ts mp ) = lyapunovValue : nextIteration
  where lyapunovValue = Point r $ lyap r $ drop ts $ temporalIteration chaoticMap (TemporalConditions ic mp r)
        nextIteration = calculateLyapunov lyap chaoticMap (BifurcationConditions rRange ic ts mp)

temporalIteration :: ChaoticMap -> TemporalConditions -> [Double]
temporalIteration chaoticMap (TemporalConditions initialCondition 0 r) = []
temporalIteration chaoticMap (TemporalConditions initialCondition n r) = currentPoint : temporalIteration chaoticMap (TemporalConditions currentPoint (n-1) r)
  where currentPoint = chaoticMap r initialCondition
