C
C     ******************************************************************
C
      SUBROUTINE MESHORTHXYXZ
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

      ! Initialize orthogonality matrices in X-Y Plane
      AlPHA2(:,:) = 0.0D0
      BETA2(:, :) = 0.0D0
      GAMMA2(:,:) = 0.0D0
      DZETA2      = REAL(1,8)/REAL((NI),8)
      DETA2       = REAL(1,8)/REAL((NJK),8)

      ! Perform orthogonality in X-Y Plane
      
      DO I = 2, NI - 1
      DO J = 2, NJK - 1
      ALPHA2(I,J)=(((OX(I+1,J  )-OX(I-1,J  ))**2.0D0)
     .            +((OY(I+1,J  )-OY(I-1,J  ))**2.0D0))
     .            /4.0D0/(DETA2**2.0D0)
      BETA2(I, J)=(((OX(I  ,J+1)-OX(I  ,J-1))
     .            * (OX(I+1,J  )-OX(I-1,J  )))
     .            +((OY(I  ,J+1)-OY(I  ,J-1))
     .            * (OY(I+1,J  )-OY(I-1,J  ))))
     .            /(4.0D0*DZETA2*DETA2)
      GAMMA2(I,J)=(((OX(I  ,J+1)-OX(I  ,J-1))**2.0D0)
     .            +((OY(I  ,J+1)-OY(I  ,J-1))**2.0D0))
     .            /4.0D0/(DZETA2**2.0D0)
      END DO
      END DO

      I=1
      DO J=2, NJK-1
      OY(I,J)=OY(I+2,J)
      END DO

      DO I=2, NI-1

C      IF ((I .LT. ITL) .AND. (I .GT. ITU) .AND. (KK .LT. 7)) THEN
C         J=1
C         OX(I,J)=OX(I,J+2)
C      END IF
        
         DO J=2, NJK-1
         
         OX(I,J)=((ALPHA2(I,J)*(OX(I  ,J+1)+OX(I  ,J-1))
     .           /(DZETA2**2.0D0))
     .           -(BETA2(I,J) *(OX(I+1,J+1)-OX(I+1,J-1)
     .           -              OX(I-1,J+1)+OX(I-1,J-1))
     .           /(2.0D0*DZETA2*DETA2))
     .           +(GAMMA2(I,J)*(OX(I+1,J)+OX(I-1,J))
     .           /(DETA2**2.0D0)))
     .           /((2.0D0*ALPHA2(I,J)/(DZETA2**2.0D0))
     .           + (2.0D0*GAMMA2(I,J)/(DETA2**2.0D0)))

         OY(I,J)=((ALPHA2(I,J)*(OY(I  ,J+1)+OY(I  ,J-1))
     .           /(DZETA2**2.0D0))
     .           -(BETA2(I,J) *(OY(I+1,J+1)-OY(I+1,J-1)
     .           -              OY(I-1,J+1)+OY(I-1,J-1))
     .           / (2.0D0*DZETA2*DETA2))
     .           +(GAMMA2(I,J)*(OY(I+1,J  )+OY(I-1,J  ))
     .           /(DETA2**2.0D0)))
     .           /((2.0D0*ALPHA2(I,J)/(DZETA2**2.0D0))
     .           + (2.0D0*GAMMA2(I,J)/(DETA2**2.0D0)))

         END DO
         J=NJK
         OX(I,J)=OX(I,J-2)
      END DO

      I=NI
      DO J=2, NJK-1
      OY(I,J)=OY(I-2,J)
      END DO

C      J=NJK
C      DO I=2,NI-1
C      OX(I,J)=2.0D0*OX(I,J-1)-OX(I,J-2)
C      END DO
      
      RETURN

      END
