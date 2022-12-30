program thread_and_buffer
	use omp_lib
	implicit none
	include 'mpif.h'
	integer :: i, tid, rank, nprocs, data(4), provide, ierr
	integer :: status(MPI_STATUS_SIZE)

	call MPI_Init_thread(MPI_THREAD_FUNNELED, provide, ierr)
	call MPI_Comm_size(MPI_COMM_WORLD, nprocs, ierr)
	call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

!$OMP PARALLEL PRIVATE(i,tid,status)
	tid = omp_get_thread_num()
	if( rank == 0 .and. tid == 0 ) then
		call MPI_Recv(data, 4, MPI_INT, 1, tid, &
						MPI_COMM_WORLD, status, ierr)
		do i=1, 4
			print *, 'data[',i,']=',data(i)
		end do
	else if( rank == 1 ) then
		data(tid+1) = tid
		if( tid == 0 ) then
			call MPI_Send(data, 4, MPI_INT, 0, tid, &
							MPI_COMM_WORLD, ierr)
		else if( tid == 1 ) then
			data(tid+1) = 10
		end if
	end if
!$OMP END PARALLEL

	call MPI_Finalize(ierr)
end
