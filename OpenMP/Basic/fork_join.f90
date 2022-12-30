program fork_join_test
    integer :: a(0:3), tid, omp_get_thread_num


    a = 0
    call omp_set_num_threads(4)
!$omp parallel private(a, tid)
    tid = omp_get_thread_num()
    a(tid) = tid
    print *, 'a(', tid, ') = ', a(tid), ' in ', tid, '-th thread'
    a(0) = 100
!$omp end parallel

    print *, 'a(0) = ', a(0)
end
