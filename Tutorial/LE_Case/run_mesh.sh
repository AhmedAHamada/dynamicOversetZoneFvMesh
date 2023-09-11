#!/bin/bash

foamCleanTutorials

cd airfoil
blockMesh
topoSet -dict system/topoSetDictR1
refineMesh -dict system/refineMeshDict1 -overwrite
topoSet -dict system/topoSetDictR2
refineMesh -dict system/refineMeshDict2 -overwrite
snappyHexMesh -overwrite | tee log.snappyHexMesh
extrudeMesh
createPatch -overwrite
transformPoints -translate '(-0.3333 0 0)'
cd ..

cd backGround
blockMesh
topoSet -dict system/topoSetDictR1
refineMesh -dict system/refineMeshDict1 -overwrite
topoSet -dict system/topoSetDictR2
refineMesh -dict system/refineMeshDict2 -overwrite
mergeMeshes . ../airfoil -overwrite
topoSet
topoSet -dict system/topoSetDict_movingZone
rm -r 0
cp -r 0_org 0
checkMesh |  tee log.checkMesh
setFields | tee log.setFields
cd ..
