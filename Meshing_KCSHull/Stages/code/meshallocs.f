C
C     ******************************************************************
C
      SUBROUTINE MESHALLOCS
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
      ALLOCATE (X(NI,NJ,NK,3))
      ALLOCATE (PX(NI),PY(NJ,NK),PZ(NJ,NK))
      ALLOCATE (OX(NI,NJ),OY(NI,NJ))
      ALLOCATE (ALPHA1(NJ,NK),BETA1(NJ,NK),GAMMA1(NJ,NK))
      ALLOCATE (ALPHA2(NI,NJ),BETA2(NI,NJ),GAMMA2(NI,NJ))
      ALLOCATE (DXS(NK),LL(NK),THETA(NK))
      ALLOCATE (Node2MatInd(N_NODE,4),Cell2Node(N_CELL,9))
      
      RETURN

      END
