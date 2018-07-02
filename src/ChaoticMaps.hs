module ChaoticMaps
    ( logisticMap
    , cubicMap
    , temporalEvolution
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
