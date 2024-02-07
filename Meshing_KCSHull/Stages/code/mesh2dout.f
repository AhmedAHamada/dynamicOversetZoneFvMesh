C
C     ******************************************************************
C
      SUBROUTINE MESH2DOUT
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
      OPEN(1,FILE=fileplace2//"2D/"//trim(adjustl(O1)),STATUS='REPLACE')
      DO J = 1, NJ
      DO K = 1, NK
         WRITE(1,*) PY(J,K),PZ(J,K)
      END DO
      END DO
      CLOSE(1)
      
      RETURN

      END
