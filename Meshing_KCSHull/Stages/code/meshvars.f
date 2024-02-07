C
C     ******************************************************************
C
      MODULE MESHVARS
C
C     ******************************************************************
C     *                                                                *
C     *   DYNAMICALLY ALLOCATED VARIABLES FOR THE MESH                 *
C     *                                                                *
C     ******************************************************************
C
      INTEGER                                   :: I, J, K, OO, PP
      INTEGER                                   :: II, JJ, KK, NJK
      INTEGER                                   :: NX, NY, NZ
      INTEGER                                   :: N_NODE, N_CELL
      INTEGER,DIMENSION(:,:)      , ALLOCATABLE :: Node2MatInd
      INTEGER,DIMENSION(:,:)      , ALLOCATABLE :: Cell2Node
      REAL(8)                                   :: RR, DTHETA, DD
      REAL(8)                                   :: PII, L, R
      REAL(8)                                   :: DZETA1, DETA1
      REAL(8)                                   :: DZETA2, DETA2
      REAL(8), DIMENSION(:,:,:,:) , ALLOCATABLE :: X
      REAL(8), DIMENSION(:,:)     , ALLOCATABLE :: PY, PZ
      REAL(8), DIMENSION(:,:)     , ALLOCATABLE :: OX, OY
      REAL(8), DIMENSION(:,:)     , ALLOCATABLE :: ALPHA1, BETA1, GAMMA1
      REAL(8), DIMENSION(:,:)     , ALLOCATABLE :: ALPHA2, BETA2, GAMMA2
      REAL(8), DIMENSION(:)       , ALLOCATABLE :: DXS, LL, THETA
      REAL(8), DIMENSION(:)       , ALLOCATABLE :: PX
      CHARACTER*8                               :: O1
      CHARACTER*12                              :: FILEPLACE1
      CHARACTER*8                               :: FILEPLACE2
      CHARACTER*11                              :: FILEPLACE3
      END MODULE MESHVARS
