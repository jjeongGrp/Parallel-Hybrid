program template
	use omp_lib
	implicit none
	include 'mpif.h'

    integer, parameter :: ITER = 8
    integer :: rank, nprocs, provide, ierr, tid, nthreads
    integer(8) :: i, max_val
    integer(8) :: istart, iend, tmp_sum, total_sum = 0
    integer(8) :: local_istart, local_iend, local_sum
    integer :: status(MPI_STATUS_SIZE), req

    call mpi_init_thread(MPI_THREAD_XXX, provide, ierr)
    call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)

    max_val = 10**ITER
    call get_start_end(max_val, rank, nprocs, istart, iend) 

    !! ......     

    if( rank == 0 ) print *, 'sum = ', total_sum

    call mpi_finalize(ierr)
End

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
