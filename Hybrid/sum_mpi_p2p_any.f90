program sum_mpi_p2p_any
    implicit none
    include 'mpif.h'
    integer, parameter :: ITER = 8
    integer :: loop, rank, nprocs, ierr, status(MPI_STATUS_SIZE)
    integer(8) :: i, max_val, istart, iend, temp_sum, total_sum(ITER) = 0
    call mpi_init(ierr)
    call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)
    do loop=1,ITER
        max_val = 10**loop
        call get_start_end(max_val, rank, nprocs, istart, iend)
        do i=istart, iend
            total_sum(loop) = total_sum(loop) + i
        end do
        if( rank > 0 ) then
            call mpi_send(total_sum(loop), 1, MPI_LONG, 0, loop, MPI_COMM_WORLD, ierr)
        else
            do i=1, nprocs-1
                call mpi_recv(temp_sum, 1, MPI_LONG, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, status, ierr)
                total_sum( status(MPI_TAG) ) = total_sum( status(MPI_TAG) ) + temp_sum
            end do
        end if
    end do
    if( rank == 0 ) then
        do i=1, ITER
            print *, "sum = ", total_sum(i)
        end do
    end if
    call mpi_finalize(ierr)
end program sum_mpi_p2p_any


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
