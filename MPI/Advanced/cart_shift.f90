PROGRAM cart_shift
  INCLUDE 'mpif.h'
  INTEGER oldcomm, newcomm, ndims, ierr
  INTEGER dimsize(0:1),coords(0:1),rank, left, right
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
  direction=0 
  displ=1
  CALL MPI_CART_SHIFT(newcomm, direction, displ, left, right, ierr)
  PRINT *, 'myrank=', myrank, 'left=', left, 'right=', right
  CALL MPI_FINALIZE(ierr)
END cart_create
