C
C     ******************************************************************
C
      SUBROUTINE MESHBCS
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
      ! Initialize theta, PY and PZ
      THETA(:) = 0.0D0
      PY(:, :) = 0.0D0
      PZ(:, :) = 0.0D0
      
      ! Set the boundary values of the mesh
      IF ((II .GE. 15) .AND. (II .LE. 253)) THEN
C      IF ((II .GE. ITL) .AND. (II .LE. ITU)) THEN
      WRITE (O1,'(I7)') II
      OPEN(2,FILE=FILEPLACE1//trim(adjustl(O1)),STATUS ='OLD')
      DO K = 1, NK
         READ(2,*) PY(1, K), PZ(1, K)
      END DO
      CLOSE(2)
      ELSEIF (II .LT. 15) THEN
      WRITE (O1,'(I7)') 15
C      ELSEIF (II .LT. ITL) THEN
C      WRITE (O1,'(I7)') ITL
      OPEN(2,FILE=FILEPLACE1//trim(adjustl(O1)),STATUS ='OLD')
      DO K = 1, NK
         READ(2,*) PY(1, K), PZ(1, K)
      END DO
      CLOSE(2)
C      ELSEIF (II .GT. ITU) THEN
C      WRITE (O1,'(I7)') ITU
      ELSEIF (II .GT. 253) THEN
      WRITE (O1,'(I7)') 253
      OPEN(2,FILE=FILEPLACE1//trim(adjustl(O1)),STATUS ='OLD')
      DO K = 1, NK
         READ(2,*) PY(1, K), PZ(1, K)
      END DO
      CLOSE(2)
C      DO K = 1, NK
C         PY(1, K) = 0.0D0 
C         PZ(1, K) = DD * (K-1)
C      END DO
      END IF
      DO K = 1, NK
         THETA(K) = DTHETA * (K-1)
         PY(NJ,K) = R * DCOS(THETA(K)*PII/180.0D0)
         PZ(NJ,K) = R * DSIN(THETA(K)*PII/180.0D0)
      END DO
      
      RETURN

      END
