#!/bin/bash

foamCleanTutorials
sh run_mesh.sh
sh run_solver.sh > log.run_solver &
