program false_sharing_solved
    integer, parameter :: N = 1000000000
    integer(8) :: total_sum=0, a(0:3*8)
    integer i,tid, omp_get_thread_num

    a = 0
    call omp_set_num_threads(4)
!$omp parallel private(tid)
    tid = omp_get_thread_num()
    !$omp do
    do i=1, N
        a(tid*8) = a(tid*8) + i
    end do
    !$omp atomic
    total_sum = total_sum + a(tid*8)
!$omp end parallel
    print *, 'sum=', total_sum
end
