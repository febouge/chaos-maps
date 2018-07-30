module Chaos.Maps
    ( logisticMap
    , cubicMap
    , lyapunovLogistic
    , lyapunovCubic
    , temporalEvolution
    , bifurcationDiagram
    , calculateLyapunov
    , cowebSeries
    ) where

import Chaos.Types
import Data.List (zip)

logisticMap :: ChaoticMap
logisticMap r x = r * x * (1 - x)

lyapunovLogistic :: LyapunovExpression
lyapunovLogistic r x = log(abs(r-2 * r * x))

computeLyapunov :: RParameter  -> LyapunovExpression -> [Double] -> LyapunovExponent
computeLyapunov r expression points = foldl (\acc x -> acc + expression r x) 0.0 points / (fromIntegral $ length points)

cubicMap :: ChaoticMap
cubicMap r x = r * x ** 3.0 + (1 - r) * x

lyapunovCubic :: LyapunovExpression
lyapunovCubic r x = log(abs(r*3*x**2)+1-r)

temporalEvolution :: ChaoticMap -> TemporalConditions -> Series
temporalEvolution chaoticMap (TemporalConditions initialCondition n r) = map convertToPoint $ zip [0.0,1..nDouble] $ temporalIteration chaoticMap (TemporalConditions initialCondition n r)
  where nDouble = fromIntegral n


bifurcationDiagram :: ChaoticMap -> BifurcationConditions -> Series
bifurcationDiagram chaoticMap (BifurcationConditions [] ic ts mp ) = []
bifurcationDiagram chaoticMap (BifurcationConditions (r:rRange) ic ts mp ) = rAnalysis ++ bifurcationDiagram chaoticMap (BifurcationConditions rRange ic ts mp)
  where rAnalysis = map (\x -> Point r x) $ drop ts $ temporalIteration chaoticMap (TemporalConditions ic mp r)


calculateLyapunov :: LyapunovExpression -> ChaoticMap -> BifurcationConditions -> Series
calculateLyapunov lyap chaoticMap (BifurcationConditions [] ic ts mp ) = []
calculateLyapunov lyap chaoticMap (BifurcationConditions (r:rRange) ic ts mp ) = lyapunovValue : nextIteration
  where lyapunovValue = Point r $ computeLyapunov r lyap $ drop ts $ temporalIteration chaoticMap (TemporalConditions ic mp r)
        nextIteration = calculateLyapunov lyap chaoticMap (BifurcationConditions rRange ic ts mp)

temporalIteration :: ChaoticMap -> TemporalConditions -> [Double]
temporalIteration chaoticMap (TemporalConditions initialCondition 0 r) = []
temporalIteration chaoticMap (TemporalConditions initialCondition n r) = currentPoint : temporalIteration chaoticMap (TemporalConditions currentPoint (n-1) r)
  where currentPoint = chaoticMap r initialCondition

convertToPoint :: (Double, Double) -> Point
convertToPoint (x,y) = Point x y

cowebSeries :: ChaoticMap -> TemporalConditions -> CowebResult
cowebSeries chaoticMap (TemporalConditions initialCondition n r) = CowebResult resultSerie chaoticMap r
  where resultSerie = (initialPoint : cowebIteration chaoticMap (TemporalConditions initialCondition n r))
        initialPoint = Point initialCondition 0.0

cowebIteration :: ChaoticMap -> TemporalConditions -> Series
cowebIteration _ (TemporalConditions _ 0 _) = []
cowebIteration chaoticMap (TemporalConditions initialCondition n r) =
  cowebIterationResult ++ cowebIteration chaoticMap (TemporalConditions (y cowebNextValue) (n-1) r)
  where cowebIterationResult = [cowebHorizontalValue, cowebNextValue]
        cowebHorizontalValue = Point initialCondition initialCondition
        cowebNextValue = Point (y cowebHorizontalValue) $ chaoticMap r (y cowebHorizontalValue)
