program Pi_hybrid
	use omp_lib
	implicit none
	include 'mpif.h'
	integer(8), parameter :: num_step=100000000
	integer(8) :: i, cnt=0, seed, local_step
	double precision :: total_pi=0.0d0, pi, x, y
	integer :: ierr, rank, nprocs
 
	call MPI_Init(ierr)
	call MPI_Comm_size(MPI_COMM_WORLD, nprocs, ierr)
	call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)

	local_step = num_step / nprocs
	if( rank < mod( num_step, nprocs) ) local_step = local_step + 1
!$omp parallel private(x,y,seed)
	seed = rank + omp_get_thread_num() + 123456789
	!$omp do reduction(+:cnt)
	do i=0, local_step-1
	 	seed = mod(125*seed+5, 2796203)
		x = dble(seed) / 2796203.0
	 	seed = mod(125*seed+5, 2796203)
		y = dble(seed) / 2796203.0
		if( sqrt(x*x + y*y) <= 1.0 ) cnt = cnt + 1
	enddo
	!$omp end do
!$omp end parallel
	
	pi = 4.0d0 * dble(cnt) / dble(local_step)
	call MPI_Reduce(pi, total_pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD, ierr)
	if( rank == 0 ) then
		total_pi = total_pi / nprocs
		write(*, 100) total_pi, dabs(dacos(-1.0d0)-total_pi)
	end if

	call MPI_Finalize(ierr)

100 format("PI =", F17.15, "(Error =", E11.5,")")
end program Pi_cal
