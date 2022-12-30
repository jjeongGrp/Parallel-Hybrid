program sync_atomic
    integer, parameter :: N=20

    integer :: i, sum=0, omp_get_thread_num
    integer, dimension(0:N-1) :: A, B

    do i=0, N-1
        A(i) = i+1
        B(i) = i+2
    end do

    call omp_set_num_threads(4)
!$omp parallel
    !$omp do
    do i=0, N-1
        !$omp atomic
        sum = sum + A(i) * B(i)
    end do
!$omp end parallel

    print *, 'sum =', sum
end
