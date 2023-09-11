# OFJ_Modified_Overset
The overset module has been enhanced to handle combined motion and deformation.

The process of numerically studying the motion of some biological systems in fluid flows starts with having an adequate numerical tool to solve the complex FSI problem. This numerical tool can be divided into mesh motion utility, fluid solver, and structure solver. In the presented work, the Overset technique is selected to be the mesh motion utility, addressing the dynamic mesh motion. Although OpenFOAM's Overset method has been widely used, there are still some types of motion that it cannot address. The normal Overset allows for solid body motion for the front mesh or the background mesh. In addition, it allows to have the displacement of any of the patches in the front mesh. However, to have a combined motion that consists of displacement for a given patch in the front mesh while having a solid body motion at the same time was not possible. A new mesh deformation solver is introduced for that purpose. A 2D airfoil problem is solved with fixed boundary conditions to validate the functionality of the new feature. The aim of the presented work is to prove that the \textit{dynamicOversetZoneFvMesh} is not only capable of applying rigid body motion coupled with deformation at selected patches in certain zones but that it can also provide a stable solution with no errors or large non-conservation interpolation in the numerical schemes used. Since the intent of the illustrative part of the project is to achieve a prescribed motion, no mesh-independent solution or mesh quality test is required. However, two cases have been meticulously simulated, allowing for a comparative analysis between the original and modified versions of the \textit{dynamicOverset} libraries. The first case is a rigid body flapping foil with no deformation, while the second case features shape flexibility during the flapping cycle characterized by leading-edge deformation. The results obtained with the modified \textit{dynamicOversetZoneFvMesh} solver stand as compelling evidence of the proficiency of the adapted solver, as it adeptly manages complex fluid dynamics while effectively accommodating the requisite motion and deformations within the front mesh and keeping the background stationary as intended. The presented work can be a cornerstone for many problems in the field of fluid-structure interaction which may have been impossible to achieve so far.
