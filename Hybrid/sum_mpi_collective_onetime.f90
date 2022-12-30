program sum_mpi_collective2

    implicit none
    include 'mpif.h'
    integer, parameter :: ITER = 8
    integer :: loop, rank, nprocs, ierr
    integer(8) :: i, max_val, istart, iend
    integer(8) :: total_sum(ITER), local_sum(ITER) = 0
    call mpi_init(ierr)
    call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
    call mpi_comm_rank(MPI_COMM_WORLD, rank, ierr)
    do loop=1,ITER
        max_val = 10**loop
        call get_start_end(max_val, rank,nprocs, istart, iend)
        do i=istart, iend
            local_sum(loop) = local_sum(loop) + i
        end do
        call mpi_reduce(local_sum, total_sum, ITER, &
            MPI_DOUBLE_PRECISION, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
    end do
    if( rank == 0 ) then
        do i=1, ITER
            print *, 'sum = ', total_sum(i)
        end do
    end if
    call mpi_finalize(ierr)
    
end program sum_mpi_collective2





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
