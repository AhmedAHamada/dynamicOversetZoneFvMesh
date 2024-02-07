      PROGRAM MESHGEN
C
C     ******************************************************************
C     *                                                                *
C     *        CREATING MESH FOR A HULL IN A MULTIPHASE FLOW           *
C     *                                                                *
C     ******************************************************************
C
      USE MESHPARAMS
      USE MESHVARS
C
C     ******************************************************************
C
      IMPLICIT NONE
C
C     ******************************************************************
C
C      COMMON/LIM/ NI,NJ,NK
C
C     ******************************************************************
C
C      INTEGER  :: NI,NJ,NK
C
C     ******************************************************************
C
C     ******************************************************************
C     DEFINING MESH PARAMETERS
C     ******************************************************************
C
      CALL MESHINPUT
C
C     ******************************************************************
C     OTHER DEFINITIONS
C     ******************************************************************
C
      FILEPLACE1 = "../hullMesh/"
      FILEPLACE2 = "../mesh/"
      FILEPLACE3 = "../mesh/3D/"

      NX        = NI - 1
      NY        = NJ - 1
      NZ        = NK - 1
      N_NODE=NI*NJ*NK
      N_CELL=NX*NY*NZ

      PII=DACOS(-1.0D0)

      ! Calculate the steps
      DTHETA = -THETAF/(NK-1)
      DD     = -D     /(NK-1)

      L = XI - XF
      R = 2.0D0*L
C
C     ******************************************************************
C     ALLOCATING MESH VARIABLES
C     ******************************************************************
C
      CALL MESHALLOCS
C
C     ******************************************************************
C     READING THE LOCATIONS ALONG X DIRECTION
C     ******************************************************************
C
      CALL MESHX
C
C     ******************************************************************
C     START SAVING THE 3D MESH POINTS
C     ******************************************************************
C

      X(:,:,:,:) = 0.0D0
      OPEN(4,FILE=FILEPLACE2//"3D/MESH3D",STATUS='REPLACE')
      WRITE(4,*) NI, NJ, NK, ITL, ITU
C
C     ******************************************************************
C     START LOOP ALONG X DIRECTION
C     ******************************************************************
C
      DO II = 1, NI
C
C     ******************************************************************
C     READING THE BOUNDARY EDGES OF Y-Z PLANE AT EACH CROSS SECTION II
C     ******************************************************************
C
      CALL MESHBCS 
C
C     ******************************************************************
C     CLUSTERING IN Y-Z PLANE AT EACH CROSS SECTION II
C     ******************************************************************
C
      CALL MESHCLUSTER 
C
C     ******************************************************************
C     ORTHOGONALITY IN 2D (Y-Z PLANE) AT EACH CROSS SECTION II
C     ******************************************************************
C
      DO I = 1, NORTH2D
         CALL MESHORTHYZ
      END DO
C
C     ******************************************************************
C     SAVING 2D (Y-Z) PLANE MESH POINTS AT EACH CROSS SECTION II
C     ******************************************************************
C
C      CALL MESH2DOUT
C
C     ******************************************************************
C     SAVING 3D MESH POINTS AT EACH CROSS SECTION II
C     ******************************************************************
C
      CALL MESH3DOUTI
C
C     ******************************************************************
C     END LOOP ALONG X DIRECTION
C     ******************************************************************
C      
      END DO
C
C     ******************************************************************
C     END SAVING THE 3D MESH POINTS
C     ******************************************************************
C
      CLOSE(4)
C
C     ******************************************************************
C     ORTHOGONALITY IN 3D
C     ******************************************************************
C
      DO PP = 1, NORTH3D
C
C     ORTHOGONALITY IN X-Z PLANE AT EACH CROSS SECTION JJ
C
      NJK = NJ
      DO JJ = 2, NJ
         OX(:,:) = 0.0D0
         OY(:,:) = 0.0D0
         DO I = 1, NI
            DO K = 1, NK
               OX(I,K) = X(I,JJ,K,1)
               OY(I,K) = X(I,JJ,K,3)
            END DO
         END DO
         CALL MESHORTHXYXZ
         DO I = 1, NI
            DO K = 1, NK
               X(I,JJ,K,1) = OX(I,K)
               X(I,JJ,K,3) = OY(I,K)
            END DO
         END DO
      END DO
C
C     ORTHOGONALITY IN X-Z PLANE AT EACH CROSS SECTION KK
C
      KK = NK
      OX(:,:) = 0.0D0
      OY(:,:) = 0.0D0
      DO I = 1, NI
         DO J = 1, NJ
            OX(I,J) = X(I,J,KK,1)
            OY(I,J) = X(I,J,KK,3)
         END DO
      END DO
      CALL MESHORTHXYXZ
      DO I = 1, NI
         DO J = 1, NJ
            X(I,J,KK,1) = OX(I,J)
            X(I,J,KK,3) = OY(I,J)
         END DO
      END DO
C
C     ORTHOGONALITY IN Y-Z PLANE AT EACH CROSS SECTION II
C      
      DO JJ = 1, NI
         PY(:,:) = 0.0D0
         PZ(:,:) = 0.0D0
         DO J = 1, NJ
            DO K = 1, NK
               PY(J,K) = X(JJ,J,K,2)
               PZ(J,K) = X(JJ,J,K,3)
            END DO
         END DO
         CALL MESHORTHYZ
         DO J = 1, NJ
            DO K = 1, NK
               X(JJ,J,K,2) = PY(J,K)
               X(JJ,J,K,3) = PZ(J,K)
            END DO
         END DO
      END DO
C
C     ORTHOGONALITY IN X-Y PLANE AT EACH CROSS SECTION KK
C
      DO KK = 1, NK
         OX(:,:) = 0.0D0
         OY(:,:) = 0.0D0
         DO I = 1, NI
            DO J = 1, NJ
               OX(I,J) = X(I,J,KK,1)
               OY(I,J) = X(I,J,KK,2)
            END DO
         END DO
         CALL MESHORTHXYXZ
         DO I = 1, NI
            DO J = 1, NJ
               X(I,J,KK,1) = OX(I,J)
               X(I,J,KK,2) = OY(I,J)
            END DO
         END DO
      END DO

      END DO


      X(:,:,NK,2)=0.0D0
C
C     ******************************************************************
C     GENERATE A VTK 3D FILE TO VISUALIZE THE MESH
C     ******************************************************************
C
      CALL MESHVTK

      END

