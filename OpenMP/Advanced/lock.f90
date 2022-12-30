program lock
    integer, parameter :: OMP_LOCK_KIND=8
    integer :: x=1
    integer(kind=OMP_LOCK_KIND) LCK

    call omp_init_lock(LCK)

    call omp_set_num_threads(4)
!$omp parallel 
    call omp_set_lock(LCK)
    x = x + 1
    print *, 'x=',x
    call omp_unset_lock(LCK)
!$omp end parallel
    call omp_destroy_lock(LCK)
end
