program hello_world
    integer omp_get_thread_num

!$omp parallel
    print *, 'Hello World', omp_get_thread_num()
!$omp end parallel
end
