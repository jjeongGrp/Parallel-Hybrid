program inner_product
    integer, parameter :: N=20

    integer :: i, sum
    integer, dimension(0:N-1) :: A, B

    do i=0, N-1
        A(i) = i+1
        B(i) = i+2
    end do

    do i=0, N-1
        sum = sum + A(i) * B(i)
    end do

    print *, 'sum =', sum
end
