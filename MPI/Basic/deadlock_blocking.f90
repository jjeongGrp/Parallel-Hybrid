! Example name : deadlock_blocking.f90
! if buf_size > 4KB is deadlock
! -----------------------------------------------------------
PROGRAM  deadlock_blocking
INCLUDE  'mpif.h'
	INTEGER  nrank, nprocs, i, ierr
	INTEGER,  PARAMETER :: buf_size = 1500
	DOUBLE PRECISION , DIMENSION(buf_size) :: a, b
	INTEGER status(MPI_STATUS_SIZE)

	CALL  MPI_INIT(ierr)
	CALL  MPI_COMM_RANK(MPI_COMM_WORLD, nrank, ierr)
	CALL  MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
IF (nrank == 0) THEN
	CALL MPI_SEND(a, buf_size, MPI_DOUBLE_PRECISION, 1, 17, MPI_COMM_WORLD, ierr)
	CALL MPI_RECV(b, buf_size, MPI_DOUBLE_PRECISION, 1, 19, MPI_COMM_WORLD, status, ierr)
ELSE IF (nrank == 1) THEN
	CALL MPI_SEND(a, buf_size, MPI_DOUBLE_PRECISION, 0, 19, MPI_COMM_WORLD, ierr)
	CALL MPI_RECV(b, buf_size, MPI_DOUBLE_PRECISION, 0, 17, MPI_COMM_WORLD, status, ierr)
ENDIF
	
CALL MPI_FINALIZE(ierr)

END

