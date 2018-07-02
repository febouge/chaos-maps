module Types where


type RParameter = Double

type InitialCondition = Double

type TransitorySteps = Int

type ChaoticMap = RParameter -> Double -> Double

-- data ChaoticMapConditions = ChaoticMapConditions { transitorySteps :: TransitorySteps
--                                                  , intialCondition :: InitialCondition
--                                                  , rParameter :: RParameter
--                                                  }

data TemporalConditions = TemporalConditions { initialCondition :: InitialCondition
                                             , numberOfPoints :: Int
                                             , r :: RParameter
                                             }

data Point = Point { x :: Double
                   , y :: Double
                   } deriving (Eq, Show, Ord)

type Series = [Point]
