program flush1
    integer :: x, tid, omp_get_thread_num

    call omp_set_num_threads(4)
!$omp parallel private(tid)
    x = 0
    tid = omp_get_thread_num()
    if( tid == 0 ) then
        call sleep(3)
        x = 1
        call sleep(3)
    end if
    do while( x == 0 )
    end do
    print *, 'x=',x, ' in ', tid, '-th thread'
!$omp end parallel
end
