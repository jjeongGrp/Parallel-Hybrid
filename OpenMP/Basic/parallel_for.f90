program parallel_for
    integer, parameter :: N=20

    integer :: tid, i, omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel private(tid)
    tid = omp_get_thread_num()

    !$omp do
    do i=0, N-1
        print *, 'Hello World', tid, i
    end do
    !$omp end do !!! optional
!$omp end parallel
end
