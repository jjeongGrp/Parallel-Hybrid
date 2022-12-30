program fibonacci1
    integer, parameter :: N = 10
    integer i

    do i=0, N
        print *, 'fibonacci F(',i,')=',fibon(i)
    end do

    contains 
recursive integer function fibon(n) result(fib)
    integer, intent(in) :: n

    if( n < 2 ) then
        fib = n
    else
        fib = fibon(n-1) + fibon(n-2)
    end if
end function

end
