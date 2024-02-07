C
C     ******************************************************************
C
      SUBROUTINE MESHCLUSTER
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
      
      ! Set parameters for the clustering
      RR     = RRC ** (1.0D0 / (NJ - 2.0D0))
      DO K = 1, NK
      LL(K)  = DSQRT((PY(NJ,K)-PY(1,K))**2.D0+(PZ(NJ,K)-PZ(1,K))**2.D0)
      DXS(K) = LL(K) * (RR - 1.0D0) / (RRC * RR - 1.0D0)
      END DO

      ! Perform clustering
      DO K = 1, NK
      DO J = 2, NJ - 1
      PY(J,K) = PY(J-1,K)+DXS(K)*DCOS(THETA(K)*PII/180.0D0)*(RR**(J-2))
      PZ(J,K) = PZ(J-1,K)+DXS(K)*DSIN(THETA(K)*PII/180.0D0)*(RR**(J-2))
      END DO
      END DO
      
      RETURN

      END
