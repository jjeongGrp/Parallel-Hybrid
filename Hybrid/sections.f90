program sections
	use omp_lib
	implicit none
	integer, parameter :: N = 4
	integer :: i, tid

!$omp parallel private(i, tid)
	tid = omp_get_thread_num()
	if( tid /= 2 ) call sleep(2)
	!$omp sections
	!$omp section
	do i=0, N-1
		print *, 'L1 tid=',tid
	end do
	!$omp section
	do i=0, N-1
		print *, 'L2 tid=',tid
	end do
	!$omp end sections
!$omp end parallel
end
