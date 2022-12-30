PROGRAM cart_create
  INCLUDE 'mpif.h'
  INTEGER oldcomm, newcomm, ndims, ierr
  INTEGER dimsize(0:1)
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
  CALL MPI_COMM_SIZE(newcomm, newprocs, ierr)
  CALL MPI_COMM_RANK(newcomm, newrank, ierr)
  PRINT*,myrank,': newcomm=',newcomm,'newprocs=',newprocs,'newrank=',newrank
  CALL MPI_FINALIZE(ierr)
END cart_create 
