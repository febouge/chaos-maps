module Types where


type RParameter = Double

type RRange = [Double]

type InitialCondition = Double

type TransitorySteps = Int

type MaxPoints = Int

type ChaoticMap = RParameter -> Double -> Double

type LyapunovExponent = Double

type LyapunovExpression = RParameter -> Double -> LyapunovExponent


data TemporalConditions = TemporalConditions { initialCondition :: InitialCondition
                                             , numberOfPoints :: Int
                                             , r :: RParameter
                                             }

data BifurcationConditions = BifurcationConditions { rRange :: RRange
                                                   , intialCondition :: InitialCondition
                                                   , transitorySteps :: TransitorySteps
                                                   , maxCalculatedPoints :: MaxPoints
                                                   }
data Point = Point { x :: Double
                   , y :: Double
                   } deriving (Eq, Show, Ord)

type Series = [Point]
