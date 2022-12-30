PROGRAM cart_rank
INCLUDE 'mpif.h'
INTEGER oldcomm, newcomm, ndims, ierr
INTEGER dimsize(0:1),coords(0:1),rank
LOGICAL periods(0:1), reorder
CALL MPI_INIT(ierr)
CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
CALL MPI_COMM_RANK(MPI_COMM_WORLD, myrank, ierr)
oldcomm = MPI_COMM_WORLD
ndims = 2 
dimsize(0) = 3; dimsize(1) = 2
periods(0) = .TRUE.; periods(1) = .FALSE.
reorder = .TRUE.
CALL MPI_CART_CREATE(oldcomm,ndims,dimsize,periods,reorder, newcomm, ierr)
IF (myrank == 0) THEN
 DO i = 0, dimsize(0)- 1
   DO j = 0, dimsize(1)- 1
      coords(0) = i
      coords(1) = j
      CALL MPI_CART_RANK(newcomm, coords, rank, ierr)
      PRINT *, 'coords =', coords, 'rank =', rank
   ENDDO
 ENDDO
ENDIF

CALL MPI_FINALIZE(ierr)
END 
