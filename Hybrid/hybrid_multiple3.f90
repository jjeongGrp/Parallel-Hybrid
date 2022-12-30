program hybrid_multiple3
	use omp_lib
	implicit none
	include 'mpif.h'

    integer, parameter :: ITER = 8
    integer :: rank, nprocs, provide, ierr, tid, nthreads
    integer(8) :: i, max_val
    integer(8) :: istart, iend, tmp_sum, total_sum = 0
    integer(8) :: local_istart, local_iend, local_sum
    integer :: status(MPI_STATUS_SIZE), req

    call mpi_init_thread(MPI_THREAD_MULTIPLE, provide, ierr)
    call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)

    max_val = 10**ITER
    call get_start_end(max_val, rank, nprocs, istart, iend) 

!$omp parallel private(tid, nthreads, i, local_sum, &
!$omp 						local_istart, local_iend, tmp_sum)
    nthreads = omp_get_num_threads()
    tid = omp_get_thread_num()
    call get_start_end(iend-istart+1, tid, nthreads,  &
                                    local_istart, local_iend)
    local_istart = local_istart + istart - 1
    local_iend = local_iend + istart - 1

    local_sum = 0
    do  i=local_istart, local_iend
        local_sum = local_sum + i
    end do

	call mpi_reduce(local_sum, tmp_sum, 1, &
					MPI_DOUBLE, MPI_SUM, 0, &
					MPI_COMM_WORLD, ierr)
	!$omp atomic
	total_sum = total_sum + tmp_sum
!$omp end parallel

    if( rank == 0 ) print *, 'sum = ', total_sum

    call mpi_finalize(ierr)
    
end

subroutine get_start_end(n, rank, nprocs, istart, iend)
    integer, intent(in) :: n, rank, nprocs
    integer(8), intent(out) :: istart, iend
    integer :: q, r

    q = n / nprocs
    r = mod( n, nprocs )
    if( rank < r ) then
        istart = rank * q + rank + 1
        iend  = istart + q
    else
        istart = rank * q + r + 1
        iend  = istart + q - 1
    end if
	return
end subroutine get_start_end
