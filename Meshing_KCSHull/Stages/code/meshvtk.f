C
C     ******************************************************************
C
      SUBROUTINE MESHVTK
C
C     ******************************************************************
C     *                                                                *
C     *   GENERATE A VTK 3D FILE TO VISUALIZE THE MESH                 *
C     *                                                                *
C     ******************************************************************
C
      USE MESHPARAMS
C
C     ******************************************************************
C
      USE MESHVARS
C
C     ******************************************************************
C
C     CONNECTIVITY MATRIX TO POINT MESH NODE ID TO ITS DIMENSIONAL INDEX
C
      DO I=1,NI
         DO J=1,NJ
            DO K=1,NK
               OO=K+(J-1)*NK+(I-1)*NK*NJ
               Node2MatInd(OO,1)=OO-1
               Node2MatInd(OO,2)=I
               Node2MatInd(OO,3)=J
               Node2MatInd(OO,4)=K
            END DO
         END DO
      END DO
C
C     CONNECTIVITY MATRIX TO POINT MESH CELLID TO ITS NODES ID
C
      DO I=1,NX
         DO J=1,NY
            DO K=1,NZ
               OO=K+(J-1)*NZ+(I-1)*NZ*NY
               Cell2Node(OO,1)=OO
               Cell2Node(OO,2)=OO+(J-1)+(I-1)*(NZ+NY+1)
               Cell2Node(OO,3)=Cell2Node(OO,2)+1
               Cell2Node(OO,4)=Cell2Node(OO,3)+NK
               Cell2Node(OO,5)=Cell2Node(OO,4)-1
               Cell2Node(OO,6)=Cell2Node(OO,2)+NK*NJ
               Cell2Node(OO,7)=Cell2Node(OO,6)+1
               Cell2Node(OO,8)=Cell2Node(OO,7)+NK
               Cell2Node(OO,9)=Cell2Node(OO,8)-1
            END DO
         END DO
      END DO

      OPEN(UNIT=9,FILE=FILEPLACE3//"M_0.vtk",STATUS='REPLACE')
      WRITE(9,*)'# vtk DataFile Version 1.0'
      WRITE(9,*)'3D Structured Grid of HEXAHEDRON'
      WRITE(9,*)'ASCII'
      WRITE(9,*)' '
      WRITE(9,*)'DATASET UNSTRUCTURED_GRID'
      WRITE(9,*)'POINTS ',N_NODE,' float'
      DO I=1,NI
      DO J=1,NJ
      DO K=1,NK
         WRITE(9,*) X(I,J,K,1),' ',X(I,J,K,2),' ',X(I,J,K,3)
      END DO
      END DO
      END DO
      WRITE(9,*)' '
      WRITE(9,*)'CELLS ',N_CELL,' ',9*N_CELL
      WRITE(9,*)' '
      DO I=1,N_CELL
         WRITE(9,*)'8 ',Cell2Node(I,2)-1,' ',Cell2Node(I,3)-1,' ',
     .                  Cell2Node(I,4)-1,' ',Cell2Node(I,5)-1,' ',
     .                  Cell2Node(I,6)-1,' ',Cell2Node(I,7)-1,' ',
     .                  Cell2Node(I,8)-1,' ',Cell2Node(I,9)-1
      END DO
      WRITE(9,*)' '
      WRITE(9,*)'CELL_TYPES ',N_CELL
      WRITE(9,*)' '
      DO I=1,N_CELL
         WRITE(9,*)'12'
      END DO
      WRITE(9,*)' '
      WRITE(9,*)'POINT_DATA ',N_NODE
      WRITE(9,*)'SCALARS Vertex float'
      WRITE(9,*)'LOOKUP_TABLE default0'
      WRITE(9,*)' '
      DO I=1,N_NODE
         WRITE(9,*) Node2MatInd(I,1)
      END DO
      WRITE(9,*)' '
      WRITE(9,*)'VECTORS node2matind float'
      DO I=1,N_NODE
         WRITE(9,*) Node2MatInd(I,2),' ',
     .              Node2MatInd(I,3),' ',
     .              Node2MatInd(I,4)
      END DO
      WRITE(9,*)' '
      CLOSE(9)
      
      RETURN

      END
