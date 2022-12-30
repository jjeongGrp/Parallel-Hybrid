program task
	use omp_lib
	implicit none
	integer, parameter :: N = 100
	integer :: i, tid, a(N)

!$omp parallel private(tid)
	tid = omp_get_thread_num()
	!$omp do
	do i=0, N-1
		a(i) = i
		!$omp task
			print *, 'a(', i, ')=', a(i), ' tid=', tid, &
					' real tid=', omp_get_thread_num()
		!$omp end task
	end do
	!$omp end do

	print *, 'end ', tid, ' thread'
!$omp end parallel
end
