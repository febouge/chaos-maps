module Chaos.Map.OperationSpec (spec) where

import           Chaos.Map
import           Chaos.Type
import           Test.Hspec

spec :: Spec
spec = do

  describe "Logistic map" $ do
    describe "Evaluation" $ do
      it "With r = 1 and x = 1, the evaluation must be 0" $ do
        evaluate LogisticMap 1.0 1.0 `shouldBe` 0.0

    describe "Temporal evolution" $ do
      it "Must contain 100 elements" $ do
        length (runLogisticMapTemporal 0.5 100 2.0) `shouldBe` 100

      it "Must converge to zero when 0 < r< 1" $ do
        last (runLogisticMapTemporal 0.5 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)
        last (runLogisticMapTemporal 0.99 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)
        last (runLogisticMapTemporal 0.01 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)

    describe "Bifurcation Diagram" $ do
      it "Must contain 160 elements" $ do
        length (bifurcationDiagram $ DiagramConditions LogisticMap [1,2] 0.5 20 100) `shouldBe` 160

    describe "Lyapunov exponent" $ do
      it "Must contain 2 elements" $ do
        length (calculateLyapunov $ DiagramConditions LogisticMap [1,2] 0.5 20 100) `shouldBe` 2

    describe "Coweb diagram" $ do
      it "Must contain 7 elements" $ do
        let result = cowebSeries $ TemporalConditions LogisticMap 0.5 3 2
        length (series result) `shouldBe` 7
        r result `shouldBe` 2

  describe "Cubic map" $ do
    describe "Evaluation" $ do
      it "With r = 1 and x = 1, the evaluation must be 1" $ do
        evaluate CubicMap 1.0 1.0 `shouldBe` 1.0



runLogisticMapTemporal :: InitialCondition -> Int -> Parameter -> Series
runLogisticMapTemporal ic n rParam = temporalEvolution tc
  where
    tc = TemporalConditions LogisticMap ic n rParam
