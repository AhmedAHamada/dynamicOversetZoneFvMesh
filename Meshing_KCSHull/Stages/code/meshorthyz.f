C
C     ******************************************************************
C
      SUBROUTINE MESHORTHYZ
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
      ! Initialize orthogonality matrices in Y-Z Plane
      AlPHA1(:,:) = 0.0D0
      BETA1(:, :) = 0.0D0
      GAMMA1(:,:) = 0.0D0
      DZETA1      = REAL(1,8)/REAL((NJ),8)
      DETA1       = REAL(1,8)/REAL((NK),8)

      ! Perform orthogonality in Y-Z Plane
C      DO I = 1, NORTH1
      
      DO J = 2, NJ - 1
      DO K = 2, NK - 1
      ALPHA1(J,K)=(((PY(J+1,K  )-PY(J-1,K  ))**2.0D0)
     .            +((PZ(J+1,K  )-PZ(J-1,K  ))**2.0D0))
     .            /4.0D0/(DETA1**2.0D0)
      BETA1(J, K)=(((PY(J  ,K+1)-PY(J  ,K-1))
     .            * (PY(J+1,K  )-PY(J-1,K  )))
     .            +((PZ(J  ,K+1)-PZ(J  ,K-1))
     .            * (PZ(J+1,K  )-PZ(J-1,K  ))))
     .            /(4.0D0*DZETA1*DETA1)
      GAMMA1(J,K)=(((PY(J  ,K+1)-PY(J  ,K-1))**2.0D0)
     .            +((PZ(J  ,K+1)-PZ(J  ,K-1))**2.0D0))
     .            /4.0D0/(DZETA1**2.0D0)
      END DO
      END DO

      DO J=2, NJ-1

C         K=1
C         PY(J,K)=PY(J,K+2)
         
         DO K=2, NK-1
         
         PY(J,K)=((ALPHA1(J,K)*(PY(J  ,K+1)+PY(J  ,K-1))
     .           /(DZETA1**2.0D0))
     .           -(BETA1(J,K) *(PY(J+1,K+1)-PY(J+1,K-1)
     .           -              PY(J-1,K+1)+PY(J-1,K-1))
     .           /(2.0D0*DZETA1*DETA1))
     .           +(GAMMA1(J,K)*(PY(J+1,K)+PY(J-1,K))
     .           /(DETA1**2.0D0)))
     .           /((2.0D0*ALPHA1(J,K)/(DZETA1**2.0D0))
     .           + (2.0D0*GAMMA1(J,K)/(DETA1**2.0D0)))

         PZ(J,K)=((ALPHA1(J,K)*(PZ(J  ,K+1)+PZ(J  ,K-1))
     .           /(DZETA1**2.0D0))
     .           -(BETA1(J,K) *(PZ(J+1,K+1)-PZ(J+1,K-1)
     .           -              PZ(J-1,K+1)+PZ(J-1,K-1))
     .           / (2.0D0*DZETA1*DETA1))
     .           +(GAMMA1(J,K)*(PZ(J+1,K  )+PZ(J-1,K  ))
     .           /(DETA1**2.0D0)))
     .           /((2.0D0*ALPHA1(J,K)/(DZETA1**2.0D0))
     .           + (2.0D0*GAMMA1(J,K)/(DETA1**2.0D0)))

         END DO
C         K=NK
C         PY(J,K)=PY(J,K-1)
      END DO
C      END DO

      K=1
      DO J=2,NJ-1
      PY(J,K)=2.0D0*PY(J,K+1)-PY(J,K+2)
      END DO
      
      RETURN

      END
