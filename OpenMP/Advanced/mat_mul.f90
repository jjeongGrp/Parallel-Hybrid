program mat_mul2
    integer, parameter :: N = 1999
    integer i,j,k, a(0:N,0:N), b(0:N,0:N), c(0:N,0:N)

    a = 0
    b = 0
    c = 0
    do j=0, N
        do i=0,j
            a(i,j) = i+j+1
            b(i,j) = i+j+2
        end do
    end do

    do j=0, N
        do i=0, N
            do k=0, N
                c(i,j) = c(i,j) + a(i,k)*b(k,j)
            end do
        end do
    end do
end
