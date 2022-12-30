program hello_wrong
    integer tid, omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel
    tid = omp_get_thread_num()
    print *, 'I am ', omp_get_thread_num(), ' tid = ', tid
!$omp end parallel
end
