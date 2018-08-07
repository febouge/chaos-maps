{-# LANGUAGE DataKinds #-}

module Chaos.Type where

type Parameter = Double

type ParameterRange = [Double]

type InitialCondition = Double

type TransitorySteps = Int

type CalculusPoints = Int

data TemporalConditions = TemporalConditions
    { mapToEvolve      :: ChaoticMap
    , initialCondition :: InitialCondition
    , numberOfPoints   :: Int
    , parameterValue   :: Parameter
    } deriving (Show)

data DiagramConditions = DiagramConditions
    { mapToAnalize    :: ChaoticMap
    , rRange          :: ParameterRange
    , intialCondition :: InitialCondition
    , transitorySteps :: TransitorySteps
    , calculusPoints  :: CalculusPoints
    } deriving (Show)

data Point = Point
    { x :: Double
    , y :: Double
    } deriving (Eq, Show, Ord)

type Series = [Point]

data CowebResult = CowebResult
    { series     :: Series
    , chaoticMap :: ChaoticMap
    , r          :: Parameter
    }

class OneDimensionalChaoticMap a where
    evaluate :: a -> Parameter -> Double -> Double
    lyapunov :: a -> Parameter -> [Double] -> Double

data ChaoticMap
    = LogisticMap
    | CubicMap
    deriving (Show)

instance OneDimensionalChaoticMap ChaoticMap where
    evaluate LogisticMap r x = r * x * (1 - x)
    evaluate CubicMap r x    = r * x ** 3.0 + (1 - r) * x

    lyapunov LogisticMap r xs
        = foldl (\acc x -> acc + log(abs(r-2 * r * x))) 0.0 xs / (fromIntegral $ length xs)
    lyapunov CubicMap r xs
        = foldl (\acc x -> acc + log(abs(r-2 * r * x))) 0.0 xs / (fromIntegral $ length xs)
