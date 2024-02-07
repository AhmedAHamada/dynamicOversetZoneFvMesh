C
C     ******************************************************************
C
      SUBROUTINE MESH3DOUTI
C
C     ******************************************************************
C     *                                                                *
C     *   ALLOCATE ARRAYS FOR THE MESHW SOLUTIONS                      *
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
      DO J = 1, NJ
      DO K = 1, NK
         X(II,J,K,1) = PX(II)/L
         X(II,J,K,2) = PY(J,K)/L
         X(II,J,K,3) = PZ(J,K)/L
         WRITE(4,*) PX(II)/L,PY(J,K)/L,PZ(J,K)/L
      END DO
      END DO
      
      RETURN

      END
