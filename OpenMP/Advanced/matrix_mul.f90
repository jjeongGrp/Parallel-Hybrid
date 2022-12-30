program mat_mul1
    integer, parameter :: N = 9
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

    print *, "matrix a"
    do i=0, N
        write(*,100) (a(i,j), j=0,N)
    end do
    print *, "matrix b"
    do i=0, N
        write(*,100) (b(i,j), j=0,N)
    end do
    print *, "matrix c"
    do i=0, N
        write(*,100) (c(i,j), j=0,N)
    end do

100 format(10(i4))
end
