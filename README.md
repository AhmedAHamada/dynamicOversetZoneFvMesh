# dynamicOversetZoneFvMesh
The overset module has been enhanced to handle combined motion and deformation.

The process of numerically studying the motion of some biological systems in fluid flows starts with having an adequate numerical tool to solve these complex FSI problems. This numerical tool can be divided into mesh motion utility, fluid solver, and structure solver. In the presented work, the Overset technique was selected to be the mesh motion utility, addressing the dynamic mesh motion. Although OpenFOAM's Overset method was widely used, there are still some types of motion that it cannot address. The conventional Overset method allowed for solid body motion for the front mesh or the background mesh. In addition, it allowed the displacement of any of the patches in the front mesh. However, to have a combined motion, that consists of displacement for a given patch in the front mesh while having a solid body motion at the same time, was not possible. A new mesh deformation solver was introduced for this purpose. A 2D airfoil problem was solved with fixed boundary conditions to validate the functionality of the new feature. The objective of this study was to demonstrate the capability of the dynamicOversetZoneFvMesh to apply both rigid body motion and deformation at specified patches within certain zones. Additionally, it aimed to conduct a numerical investigation of a leading-edge flexible flapping foil, aligning the foil's camber with the flapping direction. Verification, parallelization, validation, and mesh convergence studies were conducted prior to the numerical investigation, verifying the modified Overset solver. Two cases were meticulously simulated, allowing for a comparative analysis between the original and modified versions of the dynamicOverset libraries. The first case was a rigid body flapping foil with no deformation, while the second case featured shape flexibility during the flapping cycle characterized by leading-edge deformation. The results obtained with the modified dynamicOversetZoneFvMesh solver stood as compelling evidence of the proficiency of the adapted solver, as it adeptly managed complex fluid dynamics while effectively accommodating the requisite motion and deformations within the front mesh and keeping the background stationary as intended. Moreover, the numerical investigation showed that leading-edge flexibility boosts the power extraction efficiency of the flapping foil, aligning with the conclusions of Li et al. (2021) and Hamada and Furth (2024). The presented work can be a cornerstone for many problems in the field of fluid-structure interaction which may have been impossible to simulate so far.

![image](https://github.com/AhmedAHamada/OFJ_Modified_Overset/assets/91083913/cbccc266-9eac-483b-a335-4a4ae7f7d8f3)

![image](https://github.com/AhmedAHamada/OFJ_Modified_Overset/assets/91083913/c8f1c59a-e2fa-412e-9779-f031c0dba34f)

![T000M](https://github.com/AhmedAHamada/dynamicOversetZoneFvMesh/assets/91083913/f18f58d1-aaa0-46f6-a480-d5182b92b039)

<img width="708" alt="Parallel" src="https://github.com/AhmedAHamada/dynamicOversetZoneFvMesh/assets/91083913/060370ee-57c5-42f2-a3a8-046708a88964">

![T000F](https://github.com/AhmedAHamada/dynamicOversetZoneFvMesh/assets/91083913/221b435d-eccf-4c32-8fb0-afd49fe03081)

<img width="2316" alt="Heave_U" src="https://github.com/AhmedAHamada/dynamicOversetZoneFvMesh/assets/91083913/f9ffaad7-b55b-4b8e-ad2d-240a759dda30">

![Cp](https://github.com/AhmedAHamada/dynamicOversetZoneFvMesh/assets/91083913/2ac7ec52-77b6-4e85-a5c5-6391ff04c667)

# Authors
The modification of the solver was developed by Karim Ahmed, of the University of Poitiers, France, and Ahmed A. Hamada, of the Texas A&M University, Texas, USA, who contributed equally to this work as first authors.

# License
dynamicOversetZoneFvMesh is published under the GNU GPL Version 3 license, which can be found in the LICENSE file.

# Prerequisites
* OpenFOAM v2006/v2212/2306. While it may compile against other versions, this has not been tested and is currently not supported.

# Usage
* Make sure that OpenFOAM v2006/v2212/v2306 is loaded into your environment
* Copy the dynamicMesh/motionSolvers and dynamicMesh/Make folders to the OpenFOAM $SRC directory
* Copy the Overset Source folder to the OpenFOAM $SRC directory
* Compile all libraries and apps
* Follow these commands:
````
cp -r dynamicMesh/motionSolvers $(SRC)/dynamicMesh/
cp -r dynamicMesh/Make $(SRC)/dynamicMesh/
cp -r ./overset $(SRC)
cd $(SRC)/dynamicMesh
wmake
cd $(SRC)/overset
wmake
````

# Test cases
* All test cases can be found in the "Tutorial" directory. The deformation code for the test cases is compiled, so the user runs the solver directly.
* The user is encouraged to experiment with different settings after getting familiar with the structure of the code.
* The user is encouraged to add their deformation code in backGround/system/codeDict file.

# Paper Citation
Karim Ahmed, Ahmed A. Hamada, Ludovic Chatellier, Mirjam Furth, (2024 under review) "A Modified Overset Method in OpenFOAM for Simultaneous Motion and Deformation: A Case Study of a Flexible Flapping Foil", The OpenFOAM Journal.
Corresponding authors, Karim Ahmed and Ahmed A. Hamada contributed equally to this work as first authors.

# Contact & support
For bug reports or support, feel free to contact Karim Ahmed at karim.ahmed@univ-poitiers.fr or Ahmed A. Hamada at ahamada@tamu.edu. Please note that this code is not maintained nor regularly updated, and is only tested with OpenFOAM v2212/2306. Questions related to other versions will thus not be answered.

# Disclaimer
dynamicOversetZoneFvMesh is provided by the copyright holders and contributors "as-is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the copyright owner or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.
