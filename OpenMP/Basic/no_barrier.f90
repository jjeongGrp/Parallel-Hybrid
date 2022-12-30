program no_barrier
    integer :: x = 1

    call omp_set_num_threads(4)
!$omp parallel shared(x)
    x = x + 1
    print *, 'x =', x
!$omp end parallel

end
