module ChaoticMaps
    ( logisticMap
    , cubicMap
    , temporalEvolution
    , bifurcationDiagram
    ) where

import Types

logisticMap :: ChaoticMap
logisticMap r x = r * x * (1 - x)


cubicMap :: ChaoticMap
cubicMap r x = r * x ** 3.0 + (1 - r) * x

temporalEvolution :: ChaoticMap -> TemporalConditions -> Series
temporalEvolution chaoticMap (TemporalConditions initialCondition 0 r) = []
temporalEvolution chaoticMap (TemporalConditions initialCondition n r) = currentPoint : temporalEvolution chaoticMap (TemporalConditions nextInitial (n-1) r)
  where currentPoint = Point (fromIntegral n) nextInitial
        nextInitial = chaoticMap r initialCondition


bifurcationDiagram :: ChaoticMap -> BifurcationConditions -> Series
bifurcationDiagram chaoticMap (BifurcationConditions [] ic ts mp ) = []
bifurcationDiagram chaoticMap (BifurcationConditions (r:rRange) ic ts mp ) = rAnalysis ++ bifurcationDiagram chaoticMap (BifurcationConditions rRange ic ts mp )
  where rAnalysis = drop ts $ map (\p -> Point r (y p)) $ temporalEvolution chaoticMap (TemporalConditions ic mp r)
