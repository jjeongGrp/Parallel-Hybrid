program parallel_inner_product
    integer, parameter :: N=20

    integer :: i, tid, sum=0, omp_get_thread_num
    integer, dimension(0:N-1) :: A, B
    integer, dimension(0:3) :: C

    do i=0, N-1
        A(i) = i+1
        B(i) = i+2
    end do

    call omp_set_num_threads(4)
!$omp parallel private(tid)
    tid = omp_get_thread_num()
    C(tid) = 0
    !$omp do
    do i=0, N-1
        C(tid) = C(tid) + A(i) * B(i)
    end do
!$omp end parallel

    do i=0, 3
        sum = sum + C(i)
    end do
    print *, 'sum =', sum
end
