# Chaos Maps


[![Build Status](https://travis-ci.org/febouge/chaos-maps.svg?branch=master)](https://travis-ci.org/febouge/chaos-maps) [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

Chaotic maps are evolution functions that exhibits chaotic behavior. There are multplie plots that can extracted from chaotic maps (temporal evolution, coweb diagrams, bifurcation diagrams,...). In conjunction with a master thesis about chaotic maps I develop a Python code to analyze and plot these diagrams. Now, I am traslating the original code to Haskell.

## Features

### Maps
- Logistic map
- Cubic map

### Plots
- [x] Temporal evolution
- [x] Bifurcation diagram
- [ ] Coweb diagrams
- [x] Lyapunov exponent

### Extra
- [ ] CLI to allow user parametrization (map selection, conditions, export name, etc.)
- [ ] More testing
- [ ] SVG?

## Installation

In order to compile the project, you need Stack installed on your system. After that, run:

```bash
$ stack build && stack exec chaos-maps-exe
```