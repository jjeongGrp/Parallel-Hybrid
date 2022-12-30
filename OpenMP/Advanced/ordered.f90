program ordered
    integer i, a(0:9)

    call omp_set_num_threads(4)
!$omp parallel private(i)
    !$omp do ordered
    do i=0, 9
        a(i) = i * 2
        !$omp ordered
        print *, 'a(',i,')=',a(i)
        !$omp end ordered
    end do
!$omp end parallel
end
