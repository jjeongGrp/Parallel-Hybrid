program sync_exercise
    implicit none
    integer, parameter :: N=100

    integer :: i, sum=0, local_sum

!$omp parallel private(local_sum)
    local_sum = 0
    !$omp do
    do i=1, N
        local_sum = local_sum + i
    end do

    !$omp atomic
    sum = sum + local_sum
!$omp end parallel

    print *, 'sum =', sum
end
