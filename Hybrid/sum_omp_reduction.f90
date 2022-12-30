program sum_omp_reduction
    implicit none
    integer, parameter :: ITER = 8
    integer :: loop
    integer(8) :: i, total_sum, max_val

    do loop=1, ITER
        max_val = 10**loop
        total_sum = 0
!$omp parallel do reduction(+:total_sum)
        do i=1, max_val 
            total_sum = total_sum + i
        end do
!$omp end parallel do
        print *, 'sum = ', total_sum
    end do
end program sum_omp_reduction
