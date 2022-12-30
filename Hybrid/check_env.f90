program check_env
	use omp_lib
	implicit none
	include 'mpif.h'

	INTEGER rank, nprocs, tid, ierr

	CALL MPI_INIT(ierr)
	CALL MPI_COMM_SIZE(MPI_COMM_WORLD, nprocs, ierr)
	CALL MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)

!$OMP PARALLEL PRIVATE(tid)
	tid = omp_get_thread_num()
	print *, 'Hello World tid = ', tid, ' rank = ', rank, ' nprocs = ', nprocs
!$OMP END PARALLEL

	CALL MPI_FINALIZE(ierr)
  
  
end
