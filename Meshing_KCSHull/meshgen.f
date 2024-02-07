      PROGRAM MESHGEN
C
C     ******************************************************************
C     *                                                                *
C     *        CREATING MESH FOR A HULL IN A MULTIPHASE FLOW           *
C     *                                                                *
C     ******************************************************************
C
      IMPLICIT NONE

      INTEGER, PARAMETER         :: NJ = 49
      INTEGER, PARAMETER         :: NK = 49
      INTEGER, PARAMETER         :: NI = 289
      INTEGER, PARAMETER         :: NORTH = 1000
      INTEGER, PARAMETER         :: ITL = 33
      INTEGER, PARAMETER         :: ITU = 225
      REAL(8), PARAMETER         :: D = 0.34180D0
      REAL(8), PARAMETER         :: R = 20.0D0
      REAL(8), PARAMETER         :: RRC=2050.0D0

      INTEGER                    :: I, J, K, II
      REAL(8)                    :: RR, DTHETA, DD, PI
      REAL(8)                    :: DZETA, DETA
      REAL(8), DIMENSION(NJ, NK) :: PY, PZ
      REAL(8), DIMENSION(NJ, NK) :: ALPHA, BETA, GAMMA
      REAL(8), DIMENSION(NK)     :: DXS, LL, THETA
      CHARACTER*8                :: O1

      II=15
      write (O1,'(I7)') II

      PI=DACOS(-1.0D0)

      ! Initialize theta, PY and PZ
      THETA(:) = 0.0D0
      PY(:, :) = 0.0D0
      PZ(:, :) = 0.0D0

      ! Calculate the steps
      DTHETA = -90.0d0/(NK-1)
      DD     = -D/(NK-1)

      ! Set the boundary values of the mesh
      IF ((II .GE. ITL) .AND. (II .LE. ITU)) THEN
      OPEN(2,FILE='STAGE_'//trim(adjustl(O1))//'_1.txt',STATUS ='OLD')
      OPEN(3,FILE='STAGE_'//trim(adjustl(O1))//'_2.txt',STATUS ='OLD')
      DO K = 1, NK
         READ(2,*) PY(1, K)
         READ(3,*) PZ(1, K)
      END DO
      CLOSE(2)
      CLOSE(3)
      ELSE
      DO K = 1, NK
         PY(1, K) = 0.0D0 
         PZ(1, K) = DD * (K-1)
      END DO
      END IF
      DO K = 1, NK
         THETA(K) = DTHETA * (K-1)
         PY(NJ,K) = R * DCOS(THETA(K)*PI/180.0D0)
         PZ(NJ,K) = R * DSIN(THETA(K)*PI/180.0D0)
      END DO
    
      ! Set parameters for the clustering
      RR     = RRC ** (1.0D0 / (NJ - 2.0D0))
      DO K = 1, NK
      LL(K)  = DSQRT((PY(NJ,K)-PY(1,K))**2.D0+(PZ(NJ,K)-PZ(1,K))**2.D0)
      DXS(K) = LL(K) * (RR - 1.0D0) / (RRC * RR - 1.0D0)
      END DO

      ! Perform clustering
      DO K = 1, NK
      DO J = 2, NJ - 1
      PY(J,K) = PY(J-1,K)+DXS(K)*DCOS(THETA(K)*PI/180.0D0)*(RR**(J-2))
      PZ(J,K) = PZ(J-1,K)+DXS(K)*DSIN(THETA(K)*PI/180.0D0)*(RR**(J-2))
      END DO
      END DO

      ! Initialize orthogonality matrices
      AlPHA(:,:) = 0.0D0
      BETA(:, :) = 0.0D0
      GAMMA(:,:) = 0.0D0
      DZETA      = REAL(1,8)/REAL((NJ),8)
      DETA       = REAL(1,8)/REAL((NK),8)

      ! Perform orthogonality
      DO I = 1, NORTH
      
      DO J = 2, NJ - 1
      DO K = 2, NK - 1
      ALPHA(J,K)=(((PY(J+1,K  )-PY(J-1,K  ))**2.0D0)
     .           +((PZ(J+1,K  )-PZ(J-1,K  ))**2.0D0))
     .           /4.0D0/(DETA**2.0D0)
      BETA(J, K)=(((PY(J  ,K+1)-PY(J  ,K-1))
     .           * (PY(J+1,K  )-PY(J-1,K  )))
     .           +((PZ(J  ,K+1)-PZ(J  ,K-1))
     .           * (PZ(J+1,K  )-PZ(J-1,K  ))))
     .           /(4.0D0*DZETA*DETA)
      GAMMA(J,K)=(((PY(J  ,K+1)-PY(J  ,K-1))**2.0D0)
     .           +((PZ(J  ,K+1)-PZ(J  ,K-1))**2.0D0))
     .           /4.0D0/(DZETA**2.0D0)
      END DO
      END DO

      DO J=2, NJ-1

         K=1
         PY(J,K)=PY(J,K+2)
         
         DO K=2, NK-1
         
         PY(J,K)=((ALPHA(J,K)*(PY(J  ,K+1)+PY(J  ,K-1))
     .           /(DZETA**2.0D0))
     .           -(BETA(J,K) *(PY(J+1,K+1)-PY(J+1,K-1)
     .           -             PY(J-1,K+1)+PY(J-1,K-1))
     .           /(2.0D0*DZETA*DETA))
     .           +(GAMMA(J,K)*(PY(J+1,K)+PY(J-1,K))
     .           /(DETA**2.0D0)))
     .           /((2.0D0*ALPHA(J,K)/(DZETA**2.0D0))
     .           + (2.0D0*GAMMA(J,K)/(DETA**2.0D0)))

         PZ(J,K)=((ALPHA(J,K)*(PZ(J  ,K+1)+PZ(J  ,K-1))
     .           /(DZETA**2.0D0))
     .           -(BETA(J,K) *(PZ(J+1,K+1)-PZ(J+1,K-1)
     .           -             PZ(J-1,K+1)+PZ(J-1,K-1))
     .           / (2.0D0*DZETA*DETA))
     .           +(GAMMA(J,K)*(PZ(J+1,K  )+PZ(J-1,K  ))
     .           /(DETA**2.0D0)))
     .           /((2.0D0*ALPHA(J,K)/(DZETA**2.0D0))
     .           + (2.0D0*GAMMA(J,K)/(DETA**2.0D0)))

         END DO
C         K=NK
C         PY(J,K)=PY(J,K-1)
      END DO
      END DO

      K=1
      DO J=2,NJ-1
      PY(J,K)=2.0D0*PY(J,K+1)-PY(J,K+2)
      END DO

      OPEN(UNIT = 1, FILE = 'CHECK',STATUS = 'REPLACE')
      DO J = 1, NJ
      DO K = 1, NK
         WRITE(1,*) PY(J,K),PZ(J,K)
      END DO
      END DO
      CLOSE(1)

      END

