program nowait
    integer :: x = 1

    call omp_set_num_threads(32)
!$omp parallel
    !$omp single
    x = x + 1
    print *, 'x=',x
    !$omp end single nowait

    !$omp single
    x = x + 1
    print *, 'x=',x
    !$omp end single
!$omp end parallel
end
