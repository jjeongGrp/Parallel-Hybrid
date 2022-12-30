program master
    integer omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel
    !$omp master
    call sleep(1)
    print *, 'Hello World'
    !$omp end master
    print *, 'tid=',omp_get_thread_num()
!$omp end parallel
end
