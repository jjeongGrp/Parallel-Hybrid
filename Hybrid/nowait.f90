program nowait_test
	use omp_lib
	implicit none
	integer, parameter :: N = 20
	integer :: i, tid, a(N)

!$omp parallel private(tid)
	tid = omp_get_thread_num()
	if( tid /= 2 ) call sleep(2)
	!$omp do
	do i=0, N-1
		a(i) = i
		print *, 'a(',i,')=',a(i), ' tid=',tid
	end do
	!$omp end do nowait

	print *, 'end ', tid, ' thread'
!$omp end parallel
end
