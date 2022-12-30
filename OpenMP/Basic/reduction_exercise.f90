program reduction_excercise
    integer, parameter :: N=10

    integer :: i, fac=1

    call omp_set_num_threads(4)
!$omp parallel do reduction(*:fac)
    do i=1, N
        fac = fac * i
    end do
!$omp end parallel do

    print *, 'factorial =', fac
end
