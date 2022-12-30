program sum_omp_task
    implicit none
    integer, parameter :: ITER = 8
    integer :: loop
    integer(8) :: i, total_sum, max_val

    call omp_set_nested(1)
!$omp parallel private(max_val, total_sum)
    !$omp single
    do loop = 1, ITER
        max_val = 10**loop
        !$omp task
            total_sum = 0
            !$omp parallel do reduction(+:total_sum)
            do i=1, max_val
                total_sum = total_sum + i
            end do
            !$omp end parallel do
            print *, 'sum = ', total_sum
        !$omp end task
    end do
    !$omp end single
!$omp end parallel

end program sum_omp_task
