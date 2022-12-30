program deadlock
	implicit none
	include 'mpif.h'
	integer :: rank, nprocs, status(MPI_STATUS_SIZE), ierr
	integer :: data(50000)

	call MPI_INIT(ierr)
	call MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
	call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)

	data(1) = rank + 10
	if( rank == 0 ) then
		call MPI_Send(data, 50000, MPI_INT, 1, 11, MPI_COMM_WORLD, ierr)
		call MPI_Recv(data, 50000, MPI_INT, 1, 22, MPI_COMM_WORLD, status, ierr)
	else if( rank == 1 ) then
		call MPI_Send(data, 50000, MPI_INT, 0, 22, MPI_COMM_WORLD, ierr)
		call MPI_Recv(data, 50000, MPI_INT, 0, 11, MPI_COMM_WORLD, status, ierr)
	end if
	print *, 'rank=',rank, 'data=',data(1)

	call MPI_FINALIZE(ierr)
end
