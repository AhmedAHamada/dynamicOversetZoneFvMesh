# dynamicOversetZoneFvMesh
The overset module has been enhanced to handle combined motion and deformation.

The process of numerically studying the motion of some biological systems in fluid flows starts with having an adequate numerical tool to solve the complex FSI problem. This numerical tool can be divided into mesh motion utility, fluid solver, and structure solver. In the presented work, the Overset technique is selected to be the mesh motion utility, addressing the dynamic mesh motion. Although OpenFOAM's Overset method has been widely used, there are still some types of motion that it cannot address. The normal Overset allows for solid body motion for the front mesh or the background mesh. In addition, it allows to have the displacement of any of the patches in the front mesh. However, to have a combined motion that consists of displacement for a given patch in the front mesh while having a solid body motion at the same time was not possible. A new mesh deformation solver is introduced for that purpose. A 2D airfoil problem is solved with fixed boundary conditions to validate the functionality of the new feature. The aim of the presented work is to prove that the dynamicOversetZoneFvMesh is not only capable of applying rigid body motion coupled with deformation at selected patches in certain zones but that it can also provide a stable solution with no errors or large non-conservation interpolation in the numerical schemes used. Since the intent of the illustrative part of the project is to achieve a prescribed motion, no mesh-independent solution or mesh quality test is required. However, two cases have been meticulously simulated, allowing for a comparative analysis between the original and modified versions of the dynamicOverset libraries. The first case is a rigid body flapping foil with no deformation, while the second case features shape flexibility during the flapping cycle characterized by leading-edge deformation. The results obtained with the modified dynamicOversetZoneFvMesh solver stand as compelling evidence of the proficiency of the adapted solver, as it adeptly manages complex fluid dynamics while effectively accommodating the requisite motion and deformations within the front mesh and keeping the background stationary as intended. The presented work can be a cornerstone for many problems in the field of fluid-structure interaction which may have been impossible to achieve so far.

![image](https://github.com/AhmedAHamada/OFJ_Modified_Overset/assets/91083913/cbccc266-9eac-483b-a335-4a4ae7f7d8f3)

![image](https://github.com/AhmedAHamada/OFJ_Modified_Overset/assets/91083913/c8f1c59a-e2fa-412e-9779-f031c0dba34f)


![image](https://github.com/AhmedAHamada/OFJ_Modified_Overset/assets/91083913/8ecb044d-c49d-40bf-ad55-b8a52ed3a775)


# Authors
The modification of the solver was developed by Karim Ahmed, of the University of Poitiers, France, and Ahmed A. Hamada, of the Texas A&M University, Texas, USA.

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
Karim Ahmed, Ahmed A. Hamada, Ludovic Chatellier, Mirjam Furth, (2023 under review) "A Modified Overset Method in \OF]{A Modified Overset Method in OpenFOAM for Simultaneous Motion and Deformation: A Case Study of a Flexible Flapping Foil", The OpenFOAM Journal.
Corresponding authors, Karim Ahmed and Ahmed A. Hamada contributed equally to this work as first authors.

# Contact & support
For bug reports or support, feel free to contact Karim Ahmed at karim.ahmed@univ-poitiers.fr or Ahmed A. Hamada at ahamada@tamu.edu. Please note that this code is not maintained nor regularly updated, and is only tested with OpenFOAM v2212/2306. Questions related to other versions will thus not be answered.

# Disclaimer
dynamicOversetZoneFvMesh is provided by the copyright holders and contributors "as-is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the copyright owner or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.
