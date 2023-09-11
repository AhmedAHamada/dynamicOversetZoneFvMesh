 #!/bin/bash

cd backGround
decomposePar
mpirun -np 18 renumberMesh -overwrite -parallel | tee log.renumberMesh
mpirun -np 18 pimpleFoam -parallel | tee log.solver

