program serial_loop
    integer, parameter :: N=20

    integer :: tid=0, i, istart=0, iend=N-1
    do i=istart, iend
        print *, 'Hello World', tid, i
    end do
end
