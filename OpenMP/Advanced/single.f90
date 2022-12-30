program single
    call omp_set_num_threads(4)

!$omp parallel
    !$omp single
    print *, 'Hello World'
    !$omp end single
!$omp end parallel
end
