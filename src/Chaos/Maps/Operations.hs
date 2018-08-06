module Chaos.Maps.Operations
    ( temporalEvolution
    , bifurcationDiagram
    , calculateLyapunov
    , cowebSeries
    ) where

import           Chaos.Types
import           Data.List   (zip)

temporalEvolution :: TemporalConditions -> Series
temporalEvolution tc = convertToPoint $ zip [0.0,1..n] $ temporalIteration tc
  where
    n = fromIntegral (numberOfPoints tc)


bifurcationDiagram :: DiagramConditions -> Series
bifurcationDiagram (DiagramConditions _ [] _ _ _) = []
bifurcationDiagram (DiagramConditions chaoticMap (r:rRange) ic ts mp)
    = rAnalysis ++ bifurcationDiagram (DiagramConditions chaoticMap rRange ic ts mp)
      where rAnalysis = map (\x -> Point r x) $ drop ts $ temporalIteration $ TemporalConditions chaoticMap ic mp r


calculateLyapunov :: DiagramConditions -> Series
calculateLyapunov (DiagramConditions _ [] _ _ _) = []
calculateLyapunov (DiagramConditions chaoticMap (r:rRange) ic ts mp)
    = lyapunovValue : nextIteration
      where lyapunovValue = Point r $ lyapunov chaoticMap r $ drop ts $ temporalIteration $ TemporalConditions chaoticMap ic mp r
            nextIteration = calculateLyapunov $ DiagramConditions chaoticMap rRange ic ts mp

temporalIteration :: TemporalConditions -> [Double]
temporalIteration (TemporalConditions _ _ 0 _) = []
temporalIteration (TemporalConditions chaoticMap initialCondition n r)
    = currentPoint : temporalIteration newTc
      where currentPoint = evaluate chaoticMap r initialCondition
            newTc = TemporalConditions chaoticMap currentPoint (n-1) r

convertToPoint :: [(Double, Double)] -> [Point]
convertToPoint xs = map (\p -> Point (fst p) (snd p)) xs

cowebSeries :: TemporalConditions -> CowebResult
cowebSeries (TemporalConditions chaoticMap initialCondition n r) = CowebResult resultSerie chaoticMap r
    where resultSerie = initialPoint : cowebIteration (TemporalConditions chaoticMap initialCondition n r)
          initialPoint = Point initialCondition 0.0

cowebIteration :: TemporalConditions -> Series
cowebIteration (TemporalConditions _ _ 0 _) = []
cowebIteration (TemporalConditions chaoticMap initialCondition n r)
    = cowebIterationResult ++ (cowebIteration nextTc)
      where cowebIterationResult = [cowebHorizontalValue, cowebNextValue]
            cowebHorizontalValue = Point initialCondition initialCondition
            cowebNextValue = Point (y cowebHorizontalValue) $ evaluate chaoticMap r (y cowebHorizontalValue)
            nextTc = TemporalConditions chaoticMap (y cowebNextValue) (n-1) r
