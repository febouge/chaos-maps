module ChaoticMapsSpec (spec) where

import ChaoticMaps
import Test.Hspec
import Types

spec :: Spec
spec = do

  describe "Logistic map" $ do
    it "With r = 1 and x = 1, it must be 0" $ do
      logisticMap 1.0 1.0 `shouldBe` 0.0

  describe "Cubic map" $ do
    it "With r = 1 and x = 1 must be 1" $ do
      cubicMap 1.0 1.0 `shouldBe` 1.0

  describe "Temporal evolution" $ do
    it "Must contain 100 elements" $ do
      length (runLogisticMapTemporal 0.5 100 2.0) `shouldBe` 100

    it "Must converge to zero when 0 < r< 1" $ do
      last (runLogisticMapTemporal 0.5 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)
      last (runLogisticMapTemporal 0.99 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)
      last (runLogisticMapTemporal 0.01 100 0.5) `shouldSatisfy` (< Point 100.0 1.0e-25)

  describe "Bifurcation Diagram" $ do
    it "Must contain 160 elements" $ do
      length (bifurcationDiagram logisticMap (BifurcationConditions [1,2] 0.5 20 100)) `shouldBe` 160

  describe "Lyapunov exponent" $ do
    it "Must contain 2 elements" $ do
      length (calculateLyapunov lyapunovLogistic logisticMap (BifurcationConditions [1,2] 0.5 20 100)) `shouldBe` 2

  describe "Coweb diagram" $ do
    it "Must contain 7 elements" $ do
      length (cowebSeries logisticMap (TemporalConditions 0.5 3 2)) `shouldBe` 7
      
runLogisticMapTemporal :: InitialCondition -> Int -> RParameter -> Series
runLogisticMapTemporal ic n rParam = temporalEvolution logisticMap (TemporalConditions ic n rParam)
