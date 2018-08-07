{-# LANGUAGE OverloadedStrings #-}

module Chaos.Cli.Parser where

import           Chaos.Type
import           Data.Semigroup      ((<>))
import qualified Data.Text           as T
import           Options.Applicative

data PlotOptions
    = TemporalIteration TemporalIterationOptions
    | CowebDiagram TemporalIterationOptions
    | BifurcationDiagram DiagramOptions
    | LyapunovDiagram DiagramOptions
    deriving (Show)

data TemporalIterationOptions = TemporalIterationOptions
    { plotExportFile     :: FilePath
    , temporalConditions :: TemporalConditions
    } deriving (Show)

data DiagramOptions = DiagramOptions
    { diagramExportFile :: FilePath
    , diagramConditions :: DiagramConditions
    } deriving (Show)

cliOpts :: ParserInfo PlotOptions
cliOpts = info (commandParser <**> helper)
    (fullDesc
    <> progDesc "Command line utility to plot chaotic map diagrams"
    <> header "Chaos Maps - A command line utility to study chaotic maps"
    <> footer "Chaos Maps  Copyright (C) 2018  Ferran. \
              \ This program comes with ABSOLUTELY NO WARRANTY. \
              \ This is free software, and you are welcome to redistribute it \
              \ under certain conditions. \
              \ Source code: https://github.com/febouge/chaos-maps")

commandParser :: Parser PlotOptions
commandParser = subparser
    ( command "temporal-iteration" (info (TemporalIteration <$> temporalIterationOptions) (progDesc "Run & export temporal iteration"))
    <> command "coweb-diagram" (info (CowebDiagram <$> temporalIterationOptions) (progDesc "Run & export coweb diagram"))
    <> command "bifurcation-diagram" (info (BifurcationDiagram <$> diagramOptions) (progDesc "Run & export bifurcation diagram"))
    <> command "lyapunov-diagram" (info (LyapunovDiagram <$> diagramOptions) (progDesc "Run & export lyapunov diagram"))
    )

temporalIterationOptions :: Parser TemporalIterationOptions
temporalIterationOptions = TemporalIterationOptions
                        <$> filenameParser
                        <*> temporalConditionsParser

temporalConditionsParser :: Parser TemporalConditions
temporalConditionsParser = TemporalConditions
                        <$> chaoticMapParser
                        <*> initialConditionParser
                        <*> numberOfPointsParser
                        <*> parameterParser

diagramOptions :: Parser DiagramOptions
diagramOptions = DiagramOptions
              <$> filenameParser
              <*> diagramConditionsParser

diagramConditionsParser :: Parser DiagramConditions
diagramConditionsParser = DiagramConditions
                       <$> chaoticMapParser
                       <*> parameterRangeParser
                       <*> initialConditionParser
                       <*> transitoryStepsParser
                       <*> maxPointsParser


filenameParser :: Parser FilePath
filenameParser = strOption ( long "file"
                          <> short 'f'
                          <> metavar "FILENAME"
                          <> help "Export file name" )

chaoticMapParser :: Parser ChaoticMap
chaoticMapParser = option parseChaoticMap ( long "map"
                                         <> short 'm'
                                         <> metavar "CHAOTICMAP"
                                         <> help "The chaotic map" )

parseChaoticMap :: ReadM ChaoticMap
parseChaoticMap = eitherReader toChaoticMap
  where
    toChaoticMap :: String -> Either String ChaoticMap
    toChaoticMap s
        = case (T.toLower $ T.pack s) of
            "logisticmap" -> Right LogisticMap
            "cubicmap"    -> Right CubicMap
            _             -> Left "Unable to parse the selected map"

initialConditionParser :: Parser InitialCondition
initialConditionParser = option auto ( long "initial-condition"
                                    <> short 'i'
                                    <> metavar "INITIALCONDITION"
                                    <> help "The initial condition")

numberOfPointsParser :: Parser Int
numberOfPointsParser = option auto ( long "number-of-points"
                                  <> short 'n'
                                  <> metavar "NUMBEROFPOINTS"
                                  <> help "The number of points to plot")

parameterParser :: Parser Double
parameterParser = option auto ( long "parameter"
                             <> short 'p'
                             <> metavar "PARAMETER"
                             <> help "The parameter value for the map")

parameterRangeParser :: Parser ParameterRange
parameterRangeParser = option auto ( long "parameter-range"
                                  <> short 'r'
                                  <> metavar "PARAMETERRANGE"
                                  <> help "The parameter range for the calculus")

transitoryStepsParser :: Parser Int
transitoryStepsParser = option auto ( long "transitory-steps"
                                   <> short 't'
                                   <> metavar "TRANSITORYSTEPS"
                                   <> help "The transitory steps to discard in the calculus")

maxPointsParser :: Parser Int
maxPointsParser = option auto ( long "calculus-points"
                             <> short 'n'
                             <> metavar "CALCULUSPOINTS"
                             <> help "The points to iterate in each calculus run")
