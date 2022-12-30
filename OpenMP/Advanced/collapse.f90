program collapse
    integer, parameter :: N = 9999
    integer :: i,j, a(0:N, 0:N)

    call omp_set_num_threads(4)
!$omp parallel do private(i,j) collapse(2)
    do j=0, N
        do i=0, N
            a(i,j) = a(i,j) * 2
        end do
    end do
!$omp end parallel do
end
