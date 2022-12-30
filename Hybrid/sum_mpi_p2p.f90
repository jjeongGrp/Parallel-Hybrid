program sum_mpi_p2p
    implicit none
    include 'mpif.h'
    integer, parameter :: ITER = 8
    integer :: loop, rank, nprocs, ierr, status(MPI_STATUS_SIZE)
    integer(8) :: i, total_sum, max_val, istart, iend, local_sum

    call mpi_init(ierr)
    call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)
    do loop=1,ITER
        max_val = 10**loop
        total_sum = 0; local_sum = 0
                call get_start_end(max_val, rank, nprocs, istart, iend)
        do i=istart, iend
            local_sum = local_sum + i
        end do
        if( rank > 0 ) then
            call mpi_send(local_sum, 1, MPI_DOUBLE_PRECISION,  0,  loop,  &
                                    MPI_COMM_WORLD, ierr)
        else
            total_sum = local_sum
            do i=1, nprocs-1
                call mpi_recv(local_sum, 1, MPI_DOUBLE_PRECISION,  i,  loop,  &
                                        MPI_COMM_WORLD, status, ierr)
                total_sum = total_sum + local_sum
            end do
            print *, 'sum = ', total_sum
        end if
    end do
    call mpi_finalize(ierr)
end program sum_mpi_p2p

subroutine get_start_end(n, rank, nprocs,  &
                                        istart, iend)
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
